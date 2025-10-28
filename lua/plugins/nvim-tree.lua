return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        sort = {
            sorter = "case_sensitive",
        },
        view = {
            width = 50,
            side = "right",
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    },
    keys = {
        { "<leader>\\", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle NvimTree" },
    },
}
