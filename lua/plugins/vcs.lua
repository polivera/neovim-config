-- Version control configuration (or just git)
--

return {
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {},
        keys = {
            { "<leader>oa", "<cmd>Gitsigns blame<cr>", desc = "Gitsigns blame" },
            { "<leader>ot", "<cmd>Gitsigns blame_line<cr>", desc = "Gitsigns blame line" },
        },
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        opts = {},
        keys = {
            { "<leader>og", "<cmd>Neogit<cr>", desc = "Neogit" },
            { "<leader>ol", "<cmd>Neogit log<cr>", desc = "Neogit Log" },
        },
    },
}
