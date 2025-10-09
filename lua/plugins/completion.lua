-- Completion configuration
return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = {},
    },
    {
        "saghen/blink.cmp",
        opts = {
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
