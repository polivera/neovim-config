-- Tokyo night color scheme
-- @see https://github.com/folke/tokyonight.nvim

-- Tokyo night
return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme tokyonight-night]])
    end,
}

-- Gruvbox
-- return {
--     "ellisonleao/gruvbox.nvim",
--     priority = 1000,
--     config = function()
--         require("gruvbox").setup({
--             contrast = "hard",
--         })
--         vim.cmd("colorscheme gruvbox")
--     end,
-- }

-- Sonokai
-- return {
--     "sainnhe/sonokai",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- Optionally configure and load the colorscheme
--         -- directly inside the plugin declaration.
--         vim.g.sonokai_enable_italic = true
--         vim.cmd.colorscheme("sonokai")
--     end,
-- }
