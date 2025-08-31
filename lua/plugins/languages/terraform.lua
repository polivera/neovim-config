-- lsp configuration for lua_ls
local m = {}

m.setup = function(lspconfig)
    local globals = require("config.globals")
    lspconfig.terraformls.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        root_dir = lspconfig.util.root_pattern(".terraform", ".git", "terraform.tf"),
        filetypes = { "terraform", "terraform-vars" },
        settings = {
            terraform = {
                format = {
                    enable = true,
                },
                validation = {
                    enable = true,
                },
            },
        },
    })
end

return m
