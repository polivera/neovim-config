-- TODO: Do something with this
-- TODO: Something else
return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    lazy = false,
    opts = {},
    config = function()
        require("todo-comments").setup()
        require("telescope").load_extension("todo-comments")
    end,
    keys = {
        {
            "<leader>ft",
            "<cmd>TodoTelescope<cr>",
            desc = "Todo (Telescope)",
        },
        {
            "<leader>fT",
            "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
            desc = "Todo/Fix/Fixme (Telescope)",
        },
    },
}
