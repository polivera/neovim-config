-- Conform - File formatter
-- @see https://github.com/stevearc/conform.nvim?tab=readme-ov-file#installation

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gosimports", "goimports", "gofmt", stop_after_first = true },
        },

        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
