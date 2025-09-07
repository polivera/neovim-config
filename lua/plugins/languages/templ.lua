-- LSP configuration for lua_ls
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.templ.setup({
        on_attach = globals.lsp_default_attach,
    })
end

return M
