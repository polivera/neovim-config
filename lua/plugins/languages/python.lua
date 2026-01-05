-- LSP configuration for Python (basedpyright)
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    -- Function to detect virtual environment path
    local function get_python_path()
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
        -- Fallback to system python
        return "python3"
    end

    lspconfig.basedpyright.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = globals.get_capabilities(),
        settings = {
            basedpyright = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "standard",
                    autoImportCompletions = true,
                },
            },
            python = {
                pythonPath = get_python_path(),
            },
        },
    })
end

return M
