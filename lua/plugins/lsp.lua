-- LSP Configuration

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            require("plugins.languages.lua").setup()
            require("plugins.languages.php").setup()
            require("plugins.languages.terraform").setup(lspconfig)
        end,
    },
    { "mason-org/mason.nvim", opts = {} },
    { "mason-org/mason-lspconfig.nvim", opts = {} },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "stylua",
                "goimports-reviser",
                "intelephense",
                "php-cs-fixer",
                "phpstan",
                "terraform-ls",
            },
        },
    },
}
