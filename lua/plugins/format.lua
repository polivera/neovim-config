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
            javascript = { "prettier" },
            yaml = { "prettier" },
            vue = { "prettier" },
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
                    "--rules=@PSR12,no_extra_blank_lines,single_blank_line_at_eof,no_trailing_whitespace",
                    "--diff",
                    "$FILENAME",
                },
                stdin = false,
                timeout_ms = 30000,
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
            ["prettier"] = {
                command = "prettier",
                args = {
                    "--stdin-filepath",
                    "$FILENAME",
                    "--tab-width",
                    "2",
                    "--use-tabs",
                    "false",
                },
                stdin = true,
            },
        },
    },
}
