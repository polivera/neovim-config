-- DAP configuration for golang
local M = {}

M.setup = function()
    local dap = require("dap")

    -- PHP Debug Adapter Configuration
    dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}" },
        },
    }

    dap.configurations.go = {
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Attach to process",
            request = "attach",
            mode = "local",
            processId = function()
                local co = coroutine.running()
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                local handle = io.popen("ps -e -o pid=,comm= 2>/dev/null")
                local processes = {}
                if handle then
                    for line in handle:lines() do
                        local pid, name = line:match("^%s*(%d+)%s+(.+)$")
                        if pid and name then
                            table.insert(processes, { pid = tonumber(pid), name = vim.trim(name) })
                        end
                    end
                    handle:close()
                end

                pickers.new({}, {
                    prompt_title = "Attach to Process",
                    finder = finders.new_table({
                        results = processes,
                        entry_maker = function(entry)
                            return {
                                value = entry.pid,
                                display = string.format("[%6d] %s", entry.pid, entry.name),
                                ordinal = entry.name .. " " .. tostring(entry.pid),
                            }
                        end,
                    }),
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            coroutine.resume(co, selection.value)
                        end)
                        return true
                    end,
                }):find()

                return coroutine.yield()
            end,
        },
    }
end

return M
