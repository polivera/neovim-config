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
                -- Lua
                "lua_ls",
                "stylua",
                -- Go
                "goimports-reviser",
                -- PHP
                "intelephense",
                "php-cs-fixer",
                "phpstan",
                "php-debug-adapter",
                -- Terraform
                "terraform-ls",
            },
        },
    },
}
