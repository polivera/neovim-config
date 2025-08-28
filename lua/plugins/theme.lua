-- Tokyo night color scheme
-- @see https://github.com/folke/tokyonight.nvim

return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme tokyonight]])
    end,
}
