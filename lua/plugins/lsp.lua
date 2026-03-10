-- LSP Configuration

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local globals = require("config.globals")

            -- Global LSP configuration for all servers
            vim.lsp.config("*", {
                on_attach = globals.lsp_default_attach,
                capabilities = globals.get_capabilities(),
            })

            -- Load language-specific configurations
            require("plugins.languages.lua").setup()
            require("plugins.languages.php").setup()
            require("plugins.languages.python").setup()
            require("plugins.languages.go").setup()
            require("plugins.languages.templ").setup()
            require("plugins.languages.terraform").setup()
            require("plugins.languages.javascript").setup()
            require("plugins.languages.css").setup()
            require("plugins.languages.html").setup()
            require("plugins.languages.tailwindcss").setup()
            require("plugins.languages.docker").setup()
            require("plugins.languages.docker-compose").setup()
            require("plugins.languages.java").setup()
            require("plugins.languages.svelte").setup()

            -- Enable all language servers
            vim.lsp.enable({
                "lua_ls",
                "intelephense",
                "basedpyright",
                "gopls",
                "templ",
                "terraformls",
                "ts_ls",
                "cssls",
                "html",
                "tailwindcss",
                "dockerls",
                "docker_compose_language_service",
                "jdtls",
                "svelte",
            })
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
                "basedpyright",
                "ruff",
                "black",
                "debugpy",
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
                -- Svelte
                "svelte-language-server",
            },
        },
    },
}
