-- Neotest  Test library for neovim
-- @see: https://github.com/nvim-neotest/neotest?tab=readme-ov-file#installation
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
        "olimorris/neotest-phpunit",
    },
    opts = {},
    config = function()
        local go = require("neotest-go")({
            recursive_run = true,
            args = { "-count=1", "-timeout=60s", "-v" },
        })
        local php = require("neotest-phpunit")
        require("neotest").setup({
            adapters = {
                go,
                php,
            },
        })
    end,
}
