-- Oil file explorer
--
return {
    "stevearc/oil.nvim",
    opts = {
        delete_to_trash = true,
        view_options = {
            show_hidden = false,
        }
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    keys = {
        { "<leader>\\", "<cmd>Oil<cr>", desc = "Oil file explorer" }

    }
}
