-- Treesitter for neovim
-- @see https://github.com/nvim-treesitter/nvim-treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-b>",
                    node_incremental = "<C-b>",
                    scope_incremental = false,
                },
            },
        })
    end,
}
