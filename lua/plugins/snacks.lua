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
            win = {
                input = {
                    keys = {
                        ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                        ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                    },
                },
                list = {
                    keys = {
                        ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                        ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                    },
                },
            },
        },
    },

    keys = {
        {
            "<leader>fl",
            function()
                require("snacks").picker.git_files({
                    hidden = true,
                    untracked = true,
                })
            end,
            desc = "Find Files",
        },
        {
            "<leader>fL",
            function()
                require("snacks").picker.files({
                    title = "Find All Files",
                    hidden = true,
                    untracked = true,
                    ignored = true,
                })
            end,
            desc = "Find Files (untracked)",
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
    },
}
