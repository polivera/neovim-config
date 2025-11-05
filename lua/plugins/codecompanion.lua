-- lua/plugins/codecompanion.lua
return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            adapters = {
                http = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            env = {
                                api_key = "MY_OTHER_ANTHROPIC_KEY",
                            },
                        })
                    end,
                },
            },
            strategies = {
                chat = {
                    adapter = "anthropic",
                },
                inline = {
                    adapter = "anthropic",
                },
                agent = {
                    adapter = "anthropic",
                },
            },
        })
    end,
    keys = {
        { "<leader>ai", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
        { "<leader>ac", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "AI Chat" },
        { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
    },
}
