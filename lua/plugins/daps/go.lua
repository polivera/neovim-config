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
                return require("dap.utils").pick_process()
            end,
        },
    }
end

return M
