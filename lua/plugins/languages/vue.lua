-- LSP configuration for Vue
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")
    local mason_registry = require("mason-registry")

    lspconfig.volar.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        init_options = {
            vue = {
                hybridMode = true,
            },
            typescript = {
                tsdk = vim.fs.joinpath(
                    mason_registry.get_package("vue-language-server"):get_install_path(),
                    "node_modules",
                    "typescript",
                    "lib"
                ),
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
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
        filetypes = { "vue" },
        root_dir = lspconfig.util.root_pattern("package.json", "vue.config.js", "vite.config.ts", ".git"),
    })
end

return M
