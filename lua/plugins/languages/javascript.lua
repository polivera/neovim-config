-- LSP configuration for ts_ls
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")
    local mason_registry = require("mason-registry")

    lspconfig.ts_ls.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = mason_registry.get_package("vue-language-server"):get_install_path()
                        .. "/node_modules/@vue/language-server",
                    language = { "vue" },
                },
            },
        },
        settings = {
            typescript = {
                preferences = {
                    disableSuggestions = false,
                    includeCompletionsForModuleExports = true,
                    includeCompletionsWithInsertText = true,
                },
                suggest = {
                    includeCompletionsForModuleExports = true,
                },
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
                preferences = {
                    disableSuggestions = false,
                    includeCompletionsForModuleExports = true,
                    includeCompletionsWithInsertText = true,
                },
                suggest = {
                    includeCompletionsForModuleExports = true,
                },
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
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "templ",
        },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    })
end

return M
