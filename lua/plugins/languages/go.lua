-- LSP configuration for lua_ls
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.gopls.setup({
        on_attach = globals.lsp_default_attach,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    })
end

return M
