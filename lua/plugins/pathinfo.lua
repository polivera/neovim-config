return {
    "pathinfo.nvim",
    dev = true,
    lazy = false,
    config = function()
        local wk = require("which-key")
        require("pathinfo").setup()
        wk.add({
            { "<leader>p", group = "PathInfo" },
        })
    end,
    keys = {
        {
            "<leader>pp",
            function()
                require("pathinfo").copy_relative_path()
            end,
            desc = "Copy relative path to clipboard",
        },
        {
            "<leader>pP",
            function()
                require("pathinfo").copy_absolute_path()
            end,
            desc = "Copy absolute path to clipboard",
        },
        {
            "<leader>pv",
            function()
                require("pathinfo").copy_vcs_url()
            end,
            desc = "Copy VCS URL to clipboard",
        },
        {
            "<leader>pV",
            function()
                require("pathinfo").open_vcs_url()
            end,
            desc = "Open VCS URL on default browser",
        },
    },
}
