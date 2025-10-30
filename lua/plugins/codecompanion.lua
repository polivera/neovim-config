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
                ollama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        schema = {
                            model = {
                                default = "codellama:7b-code",
                            },
                            num_ctx = {
                                default = 8192,
                            },
                            num_predict = {
                                default = 64,
                            },
                        },
                        env = {
                            url = "http://127.0.0.1:11434",
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "ollama",
                },
                inline = {
                    adapter = "ollama",
                },
                agent = {
                    adapter = "ollama",
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
