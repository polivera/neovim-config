local function db_lock_settings()
    vim.api.nvim_create_autocmd("User", {
        pattern = "DBExecutePre",
        callback = function(args)
            --
            local bufnr = args.buf or vim.api.nvim_get_current_buf()
            local query

            -- Check if there's a visual selection
            local start_pos = vim.api.nvim_buf_get_mark(bufnr, "<")
            local end_pos = vim.api.nvim_buf_get_mark(bufnr, ">")

            -- If marks are valid and different, we had a selection
            if start_pos[1] > 0 and end_pos[1] > 0 and (start_pos[1] ~= end_pos[1] or start_pos[2] ~= end_pos[2]) then
                -- Get selected text
                local lines = vim.api.nvim_buf_get_text(
                    bufnr,
                    start_pos[1] - 1, -- 0-indexed
                    start_pos[2],
                    end_pos[1] - 1,
                    end_pos[2] + 1, -- end is inclusive
                    {}
                )
                query = table.concat(lines, "\n")
                vim.notify("Selected query:\n" .. query, vim.log.levels.INFO)
            else
                -- No selection, get entire buffer
                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                query = table.concat(lines, "\n")
                vim.notify("Full buffer query:\n" .. query, vim.log.levels.INFO)
            end
            vim.api.nvim_buf_del_mark(bufnr, "<")
            vim.api.nvim_buf_del_mark(bufnr, ">")
        end,
    })
end

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

            db_lock_settings()
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
