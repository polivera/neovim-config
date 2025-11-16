-- Define options class. This will be passed as parameter to the setup function
---@class TestongaOptions
---@field adapters AdapterInterface[]

local M = {}
local util = require("mylib")
local adapters = {
    php = require("adapters.php-adapter"),
}

M.setup = function(opts)
    opts = opts or {}
    vim.inspect(opts)
end

M.exec_current_test = function(_)
    local adapter = adapters[util.buffer.get_filetype()] or nil
    if adapter == nil then
        vim.notify("Adapter not found")
        return
    end
    local test_name = adapter:get_current_test(0, util.buffer.get_current_line_number())
    local test_file_path = util.buffer.get_absolute_path()
    if test_file_path == nil then
        return
    end
    local test_command = adapter:get_test_command(test_file_path, test_name)
    local qf_items = {}

    util.cmd.run_command(test_command, {
        on_line = function(line, stream_type)
            -- Remove leading || from output
            line = line:gsub("^%|%| ", "")

            if line ~= "" then
                local qf_item = {
                    text = line,
                }

                -- Parse file:line pattern for quickfix linking
                -- TODO: Move this to a helper function for reuse
                local file, line_num = line:match("(/[^:]+):(%d+)$")
                if file and line_num then
                    qf_item.filename = file
                    qf_item.lnum = tonumber(line_num)
                end

                table.insert(qf_items, qf_item)
                vim.fn.setqflist(qf_items)
            end
        end,
        on_exit = function(code)
            local notif_type = code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
            vim.notify("Test finish with code " .. code, notif_type)
            if code ~= 0 then
                vim.cmd("copen")
            else
                vim.cmd("cclose")
            end
        end,
    })
end

M.exec_current_file = function(_)
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.list_current_file_tests = function(_)
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.open_current_file_test = function(_)
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.create_test_for_current_file = function()
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.repeat_last_test = function()
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

return M
