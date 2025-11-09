-- Global values to use throughout neovim configuration

local M = {}

local base_lsp_keymaps = function(bufnr)
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
    vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

local telescope_lsp_keymaps = function(bufnr, telescope)
    local opts = { buffer = bufnr, silent = true }
    local wk = require("which-key")
    wk.add({
        {
            "<leader>ld",
            function()
                telescope.lsp_definitions()
            end,
            desc = "Definitions",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lr",
            function()
                telescope.lsp_references()
            end,
            desc = "References",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>li",
            function()
                telescope.lsp_implementations()
            end,
            desc = "Implementations",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ls",
            function()
                telescope.lsp_document_symbols()
            end,
            desc = "Symbols",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lS",
            function()
                telescope.lsp_workspace_symbols()
            end,
            desc = "Symbols",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ly",
            function()
                telescope.lsp_type_definitions()
            end,
            desc = "Type Definitions",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>la",
            vim.lsp.buf.code_action,
            desc = "Code Actions",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ln",
            vim.lsp.buf.rename,
            desc = "Code Rename",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>le",
            function()
                telescope.diagnostics()
            end,
            desc = "Diagnostics",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ll",
            vim.lsp.buf.hover,
            desc = "Hover Documentation",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lk",
            vim.lsp.buf.signature_help,
            desc = "Signature Help",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lf",
            function()
                vim.lsp.buf.format({ async = true })
            end,
            desc = "Format",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
    })

    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)
end

local snacks_lsp_keymaps = function(bufnr, snacks)
    local opts = { buffer = bufnr, silent = true }
    local wk = require("which-key")
    wk.add({
        {
            "<leader>ld",
            function()
                snacks.picker.lsp_definitions()
            end,
            desc = "Definitions",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lr",
            function()
                snacks.picker.lsp_declarations()
            end,
            desc = "References",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lr",
            function()
                snacks.picker.lsp_references()
            end,
            desc = "References",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>li",
            function()
                snacks.picker.lsp_implementations()
            end,
            desc = "Implementations",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ls",
            function()
                snacks.picker.lsp_symbols()
            end,
            desc = "Symbols",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ly",
            function()
                snacks.picker.lsp_type_definitions()
            end,
            desc = "Type Definitions",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>la",
            vim.lsp.buf.code_action,
            desc = "Code Actions",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ln",
            vim.lsp.buf.rename,
            desc = "Code Rename",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>le",
            function()
                snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>ll",
            vim.lsp.buf.hover,
            desc = "Hover Documentation",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lk",
            vim.lsp.buf.signature_help,
            desc = "Signature Help",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
        {
            "<leader>lf",
            function()
                vim.lsp.buf.format({ async = true })
            end,
            desc = "Format",
            mode = "n",
            buffer = bufnr,
            silent = true,
        },
    })

    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)
end

M.colorscheme = "tokionight"

M.lsp_default_attach = function(_, bufnr)
    local ok, snacks = pcall(require, "telescope.builtin")
    if ok then
        telescope_lsp_keymaps(bufnr, snacks)
        return
    end
    base_lsp_keymaps(bufnr)
end

M.get_capabilities = function()
    local ok, blink = pcall(require, "blink.cmp")
    if not ok then
        blink = { get_lsp_capabilities = function() end }
    end
    return vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities())
end

return M
