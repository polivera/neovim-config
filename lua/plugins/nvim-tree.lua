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
            indent_markers = {
                enable = true,
            },
        },
        filters = {
            dotfiles = true,
            custom = { "__pycache__" },
        },
        git = {
            enable = false,
        },
    },
    keys = {
        { "<leader>\\", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle NvimTree" },
        { "<leader>f\\", "<cmd>NvimTreeFindFile<cr>", desc = "NvimTree find file" },
    },
}
