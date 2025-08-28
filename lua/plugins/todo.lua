return {
    "folke/todo-comments.nvim",
    opts = {},
    keys = {
        {
            "<leader>st",
            function()
                require("snacks").picker.todo_comments()
            end,
            desc = "Todo",
        },
        {
            "<leader>sT",
            function()
                require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
            end,
            desc = "Todo/Fix/Fixme",
        },
    },
}
