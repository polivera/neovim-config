-- lsp configuration for lua_ls
local globals = require("config.globals")
local m = {}

m.setup = function(lspconfig)
    vim.lsp.config("terraform-ls", {
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
