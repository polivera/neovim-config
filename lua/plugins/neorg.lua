-- Neorg - Organization and note-taking in Neovim
-- @see https://github.com/nvim-neorg/neorg

return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Project/Personal/notes",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.summary"] = {},
            },
        })

        local wk = require("which-key")
        wk.add({
            { "<leader>n", group = "Neorg" },
            { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Open index" },
            { "<leader>nr", "<cmd>Neorg return<cr>", desc = "Return to previous" },
            { "<leader>nw", "<cmd>Neorg workspace notes<cr>", desc = "Open workspace" },
            { "<leader>njt", "<cmd>Neorg journal today<cr>", desc = "Journal today" },
            { "<leader>njy", "<cmd>Neorg journal yesterday<cr>", desc = "Journal yesterday" },
            { "<leader>njm", "<cmd>Neorg journal tomorrow<cr>", desc = "Journal tomorrow" },
            { "<leader>ns", "<cmd>Neorg generate-workspace-summary<cr>", desc = "Generate summary" },
        })
    end,
}
