-- LSP configuration for lua_ls
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.lua_ls.setup({
        on_attach = globals.lsp_default_attach,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = {
                        "vim",
                        "require",
                    },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end

return M
