-- LSP Configuration

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                virtual_text = false,
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            require("plugins.languages.lua").setup(lspconfig)
            require("plugins.languages.php").setup(lspconfig)
            require("plugins.languages.python").setup(lspconfig)
            require("plugins.languages.go").setup(lspconfig)
            require("plugins.languages.templ").setup(lspconfig)
            require("plugins.languages.terraform").setup(lspconfig)
            require("plugins.languages.javascript").setup(lspconfig)
            require("plugins.languages.css").setup(lspconfig)
            require("plugins.languages.html").setup(lspconfig)
            require("plugins.languages.tailwindcss").setup(lspconfig)
            require("plugins.languages.docker").setup(lspconfig)
            require("plugins.languages.docker-compose").setup(lspconfig)
            require("plugins.languages.java").setup(lspconfig)
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
                -- Python
                "pyright",
                "ruff",
                "black",
                -- Go
                "gopls",
                "goimports-reviser",
                "delve",
                "templ",
                -- PHP
                "intelephense",
                "php-cs-fixer",
                "phpstan",
                "php-debug-adapter",
                -- Terraform
                "terraform-ls",
                "terraform",
                -- Javascript
                "typescript-language-server",
                "prettier",
                "vue-language-server",
                -- HTML/CSS
                "css-lsp",
                "html-lsp",
                "tailwindcss",
                -- Docker
                "docker-language-server",
                "docker-compose-language-service",
                -- Java
                "jdtls",
            },
        },
    },
}
