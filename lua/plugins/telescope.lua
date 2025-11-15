-- lua/plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- Orderless-like matching configuration
                sorting_strategy = "ascending",
                layout_strategy = "flex",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },

                -- Fuzzy matching options (orderless-style)
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },

                -- File ignore patterns
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "vendor/",
                    "%.lock",
                },

                -- Borderless layout (like your snacks config)
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                prompt_prefix = "  ",
                selection_caret = " ",
                entry_prefix = "",

                mappings = {
                    i = {
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<esc>"] = actions.close,
                    },
                    n = {
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["q"] = actions.close,
                        ["<C-g>"] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                live_grep_args = {
                    auto_quoting = true,
                },
            },
        })

        -- Load extensions
        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
    end,
    keys = {
        {
            "<leader>fl",
            function()
                require("telescope.builtin").find_files({ hidden = true })
            end,
            desc = "Find Files (Telescope)",
        },
        {
            "<leader>fL",
            function()
                require("telescope.builtin").find_files({
                    hidden = true,
                    no_ignore = true,
                    no_ignore_parent = true,
                })
            end,
            desc = "Find All Files (Telescope)",
        },
        {
            "<leader>fu",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Switch Buffer (Telescope)",
        },
        {
            "<leader>fr",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "Recent Files (Telescope)",
        },
        {
            "<leader>fj",
            function()
                require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
            end,
            desc = "Grep (Telescope)",
        },
        {
            "<leader>f/",
            function()
                require("telescope.builtin").grep_string()
            end,
            desc = "Grep Word (Telescope)",
        },
    },
}
