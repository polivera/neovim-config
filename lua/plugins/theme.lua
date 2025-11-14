-- Tokyo night color scheme
-- @see https://github.com/folke/tokyonight.nvim

-- Tokyo night
-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd([[colorscheme tokyonight]])
--     end,
-- }

-- Gruvbox
return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            contrast = "hard",
        })
        vim.cmd("colorscheme gruvbox")
    end,
}
