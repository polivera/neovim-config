-- lsp configuration for lua_ls
local m = {}

m.setup = function(lspconfig)
    local globals = require("config.globals")
    lspconfig.html.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        root_dir = lspconfig.util.root_pattern("package.json", ".git"),
        filetypes = { "html", "templ" },
        settings = {
            css = {
                validate = true,
            },
        },
    })
end

return m
