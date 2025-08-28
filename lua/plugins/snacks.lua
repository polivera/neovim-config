-- Folke snacks
-- @see https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        indent = {
            enabled = true,
            animate = {
                enabled = false,
            },
        },
        explorer = {
            enable = true,
        },
        quickfile = {
            enable = true,
        },
        picker = {
            focus = "input",
            layout = {
                preset = "ivy",
                cycle = false,
                position = "bottom",
            },
            layouts = {
                ivy = {
                    layout = {
                        box = "vertical",
                        backdrop = false,
                        row = -1,
                        width = 0,
                        height = 0.4,
                        border = "top",
                        title = " {title} {live} {flags}",
                        title_pos = "left",
                        { win = "input", height = 1, border = "bottom" },
                        {
                            box = "horizontal",
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", width = 0.6, border = "left" },
                        },
                    },
                },
            },
            matcher = {
                frecency = true,
                cwd_bonus = true,
            },
        },
    },

    keys = {
        {
            "<leader>fl",
            function()
                require("snacks").picker.files()
            end,
            desc = "Find Files (snacks picker)",
        },
        {
            "<leader>fu",
            function()
                require("snacks").picker.buffers()
            end,
            desc = "Switch Buffer",
        },
        {
            "<leader>fr",
            function()
                require("snacks").picker.recent()
            end,
            desc = "Recent Files",
        },
        {
            "<leader>fj",
            function()
                require("snacks").picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>f/",
            function()
                require("snacks").picker.grep_word()
            end,
            desc = "Grep Word",
        },

        -- Git integration
        {
            "<leader>gl",
            function()
                require("snacks").picker.git_files()
            end,
            desc = "Git Files",
        },
        {
            "<leader>go",
            function()
                require("snacks").picker.git_log()
            end,
            desc = "Git Commits",
        },

        -- Development helpers
        {
            "<leader>le",
            function()
                require("snacks").picker.diagnostics()
            end,
            desc = "Diagnostics",
        },
        {
            "<leader>ls",
            function()
                require("snacks").picker.symbols()
            end,
            desc = "Document Symbols",
        },
    },
}
