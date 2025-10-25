-- LSP configuration for Vue
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")
    local mason_registry = require("mason-registry")

    -- Get the correct path to @vue/typescript-plugin
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()

    local vue_typescript_plugin_path = vue_language_server_path .. "/node_modules/@vue/language-server"

    -- Configure Volar (Vue Language Server)
    lspconfig.volar.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        filetypes = { "vue" },
        init_options = {
            vue = {
                hybridMode = true, -- This is critical
            },
            typescript = {
                tsdk = vue_typescript_plugin_path .. "/node_modules/typescript/lib",
            },
        },
        settings = {
            vue = {
                inlayHints = {
                    inlineHandlerLeading = true,
                    missingProps = true,
                    optionsWrapper = true,
                },
            },
        },
    })
end

return M
