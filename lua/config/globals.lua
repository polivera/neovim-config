-- Global values to use throughout neovim configuration

local M = {}

M.colorscheme = "tokio-night"
M.lsp_default_attach = function(_, bufnr)
    local opts = { buffer = bufnr, silent = true }
    -- Navigation
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>le", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)

    -- Documentation
    vim.keymap.set("n", "<leader>ll", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, opts)

    -- Code actions
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)

    -- Formatting
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- Diagnostics
    -- For diagnostics I am using snacks - @see snacks.lua
end

return M
