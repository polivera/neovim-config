return {
    "polivera/testonga.nvim",
    dev = true,
    opts = {},
    keys = {
        { "<leader>tt", "<cmd>TestongaCurrentTest<cr>", desc = "Test Current Test" },
        { "<leader>tl", "<cmd>TestongaCurrentFile<cr>", desc = "Test Current Test" },
        { "<leader>to", "<cmd>TestongaListFileTests<cr>", desc = "Test List Current File Tests" },
        { "<leader>tp", "<cmd>TestongaRepeatLastTest<cr>", desc = "Repeat Last Test" },
    },
}
