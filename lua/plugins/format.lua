-- Conform - File formatter
-- @see https://github.com/stevearc/conform.nvim?tab=readme-ov-file#installation

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports-reviser", "goimports", "gofmt", stop_after_first = true },
            php = { "php-cs-fixer" },
        },

        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },

        formatters = {
            ["php-cs-fixer"] = {
                command = "php-cs-fixer",
                args = {
                    "fix",
                    "$FILENAME",
                    "--rules=@PSR12", -- or your preferred ruleset
                    "--using-cache=no",
                },
                stdin = false,
            },
        },
    },
}
