return {
    -- Core database interaction plugin
    {
        "tpope/vim-dadbod",
        lazy = true,
    },

    -- UI for database management
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            "tpope/vim-dadbod",
            "kristijanhusak/vim-dadbod-completion",
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        keys = {
            { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
            { "<leader>dq", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB buffer" },
        },
        init = function()
            -- Configuration for vim-dadbod-ui
            vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_force_echo_notifications = 0
            vim.g.db_ui_win_position = "left"
            vim.g.db_ui_winwidth = 40

            -- Icons
            vim.g.db_ui_icons = {
                expanded = {
                    db = "▾ ",
                    buffers = "▾ ",
                    saved_queries = "▾ ",
                    schemas = "▾ ",
                    schema = "▾ 󰆼",
                    tables = "▾ 󰓫",
                    table = "▾ ",
                },
                collapsed = {
                    db = "▸ ",
                    buffers = "▸ ",
                    saved_queries = "▸ ",
                    schemas = "▸ ",
                    schema = "▸ 󰆼",
                    tables = "▸ 󰓫",
                    table = "▸ ",
                },
                saved_query = "",
                new_query = "",
                tables = "󰓫",
                buffers = "",
                add_connection = "",
                connection_ok = "✓",
                connection_error = "✕",
            }

            -- Execute query mappings within DBUI
            vim.g.db_ui_execute_on_save = 0

            -- Table helpers
            vim.g.db_ui_table_helpers = {
                postgresql = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Explain = "EXPLAIN ANALYZE {last_query}",
                    Describe = "\\d+ {table}",
                },
                mysql = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Explain = "EXPLAIN {last_query}",
                    Describe = "DESCRIBE {table}",
                },
            }
        end,
    },

    -- SQL completion
    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = "tpope/vim-dadbod",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
        config = function()
            -- Add dadbod-completion in sql files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    require("cmp").setup.buffer({
                        sources = {
                            { name = "vim-dadbod-completion" },
                            { name = "buffer" },
                        },
                    })
                end,
            })
        end,
    },
}
