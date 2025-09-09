-- LSP configuration for lua_ls
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.ts_ls.setup({
        on_attach = globals.lsp_default_attach,
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
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    })
end

return M
