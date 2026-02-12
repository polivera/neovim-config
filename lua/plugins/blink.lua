-- Completion configuration
return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("snippets.php")
        end,
    },
    {
        "saghen/blink.cmp",
        dependencies = { "L3MON4D3/LuaSnip" },
        opts = {
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    -- Add Obsidian as a completion source
                    obsidian = {
                        name = "obsidian",
                        module = "blink.compat.source",
                        score_offset = 100, -- Prioritize obsidian completions
                    },
                    obsidian_new = {
                        name = "obsidian_new",
                        module = "blink.compat.source",
                        score_offset = 90,
                    },
                    obsidian_tags = {
                        name = "obsidian_tags",
                        module = "blink.compat.source",
                        score_offset = 80,
                    },
                },
            },
            cmdline = {},
            per_filetype = {
                markdown = { "obsidian", "obsidian_new", "obsidian_tags", "lsp", "path", "snippets", "buffer" },
            },
            signature = {
                enabled = true,
                window = {
                    show_documentation = true,
                },
            },
            completion = {
                menu = {
                    auto_show = true,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                            { "kind" },
                            { "source_name" },
                        },
                    },
                },
            },
            fuzzy = {
                -- This could be change to rust, but as of this versions it won't compile
                implementation = "lua",
            },
            keymap = {
                preset = "default",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-l>"] = { "accept", "fallback" },
                ["<C-d>"] = { "show_documentation", "hide_documentation" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
        },
        -- build = "cargo build --release",
    },
}
