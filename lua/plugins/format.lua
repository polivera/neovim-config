-- Conform - File formatter
-- @see https://github.com/stevearc/conform.nvim?tab=readme-ov-file#installation

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports-reviser", "goimports", "gofmt", stop_after_first = true },
            php = { "php-cs-fixer" },
            terraform = { "terraform" },
            templ = { "templ" },
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
                    "--rules=@PSR12,no_extra_blank_lines,single_blank_line_at_eof,no_trailing_whitespace", -- or your preferred ruleset
                    "--using-cache=no",
                    "--diff",
                    "$FILENAME",
                },
                stdin = false,
            },
            ["terraform"] = {
                command = "terraform",
                args = {
                    "fmt",
                    "-diff",
                    "$FILENAME",
                },
                stdin = false,
            },
            ["templ"] = {
                command = "templ",
                args = {
                    "fmt",
                },
                stdin = true,
            },
        },
    },
}
