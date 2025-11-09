-- Version control configuration (or just git)
--

return {
    {
        "sindrets/diffview.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
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
        opts = {
            commit_editor = {
                -- kind = "split",
                staged_diff_split_kind = "vsplit",
                show_staged_diff = true,
            },
        },
        keys = {
            { "<leader>og", "<cmd>Neogit<cr>", desc = "Neogit" },
            { "<leader>ol", "<cmd>Neogit log<cr>", desc = "Neogit Log" },
            {
                "<leader>of",
                function()
                    require("neogit").open({ "log", "--", vim.fn.expand("%") })
                end,
                desc = "Neogit File Log",
            },
        },
    },
}
