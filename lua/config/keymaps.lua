-- Keymaps configuration
-- All keymaps configurations not related to a plugin

local M = {}

M.init = function()
    -- Default keymaps opts
    local opts = { noremap = true, silent = true }

    -- Configure leader key
    -- Set Leader Key
    vim.keymap.set("", " ", "<Nop>", opts)
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- Quick save and quit
    vim.keymap.set("n", "<leader>w", ":w<cr>", opts)
    vim.keymap.set("n", "<leader>q", ":bw<cr>", opts)
    vim.keymap.set("n", "<leader>Q", ":qa<cr>", opts)

    -- Case transformation
    vim.keymap.set({ "n", "v" }, "tu", "gU", opts)
    vim.keymap.set({ "n", "v" }, "tl", "gu", opts)
    vim.keymap.set({ "n", "v" }, "tt", "~", opts) -- Toggle case

    -- Cancel with ctrl + g or escape
    vim.keymap.set({ "i", "v", "x" }, "<C-g>", "<esc>", opts)

    -- Keep cursor centered when navigating search results and joining lines
    vim.keymap.set("n", "n", "nzzzv", opts)
    vim.keymap.set("n", "N", "Nzzzv", opts)
    vim.keymap.set("n", "J", "mzJ`z", opts)

    -- Stay in visual mode after indenting
    vim.keymap.set("v", "<", "<gv", opts)
    vim.keymap.set("v", ">", ">gv", opts)

    -- Indentation in normal mode
    vim.keymap.set("n", "<", "<<", opts)
    vim.keymap.set("n", ">", ">>", opts)

    -- Register management: m to cut, d to delete without yanking, c to change without yanking
    vim.keymap.set({ "n", "x", "v" }, "m", "d", opts)
    vim.keymap.set({ "n", "x", "v" }, "M", "D", opts)
    vim.keymap.set({ "n", "x", "v" }, "mm", "dd", opts)
    vim.keymap.set({ "n", "x", "v" }, "d", '"_d', opts)
    vim.keymap.set({ "n", "x", "v" }, "D", '"_D', opts)
    vim.keymap.set({ "n", "x", "v" }, "c", '"_c', opts)
    vim.keymap.set({ "n", "x", "v" }, "C", '"_C', opts)
    vim.keymap.set({ "n", "x", "v" }, "x", '"_x', opts)
    vim.keymap.set({ "n", "x", "v" }, "X", '"_X', opts)
    vim.keymap.set("v", "p", '"_dP', opts) -- Don't overwrite register when pasting in visual mode

    -- Activate sessionizer
    vim.keymap.set("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer.sh<CR>", opts)
end

return M
