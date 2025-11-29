return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)

        wk.add({
            { "<leader>b", group = "Obsidian" },
            { "<leader>h", group = "Harpoon" },
            { "<leader>f", group = "Find" },
            { "<leader>l", group = "LSP" },
            { "<leader>o", group = "Git" },
            { "<leader>s", group = "TODOs" },
            { "<leader>x", group = "Trouble" },
            { "<leader>a", group = "Tabs" },
        })
    end,
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
