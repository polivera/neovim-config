-- DAP configuration for Python
local M = {}

M.setup = function()
    local dap = require("dap")

    -- Python Debug Adapter Configuration
    dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv then
                    return venv .. "/bin/python"
                end
                -- Try common venv locations
                local cwd = vim.fn.getcwd()
                local venv_paths = {
                    cwd .. "/.venv/bin/python",
                    cwd .. "/venv/bin/python",
                    cwd .. "/env/bin/python",
                }
                for _, path in ipairs(venv_paths) do
                    if vim.fn.filereadable(path) == 1 then
                        return path
                    end
                end
                return "python3"
            end,
        },
        {
            type = "python",
            request = "launch",
            name = "Launch file with arguments",
            program = "${file}",
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " +")
            end,
            pythonPath = function()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv then
                    return venv .. "/bin/python"
                end
                local cwd = vim.fn.getcwd()
                local venv_paths = {
                    cwd .. "/.venv/bin/python",
                    cwd .. "/venv/bin/python",
                    cwd .. "/env/bin/python",
                }
                for _, path in ipairs(venv_paths) do
                    if vim.fn.filereadable(path) == 1 then
                        return path
                    end
                end
                return "python3"
            end,
        },
        {
            type = "python",
            request = "attach",
            name = "Attach remote",
            connect = function()
                local host = vim.fn.input("Host [127.0.0.1]: ")
                host = host ~= "" and host or "127.0.0.1"
                local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
                return { host = host, port = port }
            end,
        },
    }
end

return M
