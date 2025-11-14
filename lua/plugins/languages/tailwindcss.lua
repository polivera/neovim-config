-- LSP configuration for Tailwind CSS
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.tailwindcss.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = globals.get_capabilities(),
        filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
            "templ",
            "php",
        },
        init_options = {
            userLanguages = {
                templ = "html",
                vue = "html",
            },
        },
        settings = {
            tailwindCSS = {
                experimental = {
                    classRegex = {
                        -- Vue specific patterns
                        { "class[:]\\s*['\"]([^'\"]*)['\"]", "['\"]([^'\"]*)['\"]" },
                        -- Standard patterns
                        "class:\\s*?[\"'`]([^\"'`]*).*?[\"'`]",
                        "[\"'`]([^\"'`]*.*?)\\s*[\"'`]",
                    },
                },
                validate = true,
                lint = {
                    cssConflict = "warning",
                    invalidApply = "error",
                    invalidScreen = "error",
                    invalidVariant = "error",
                    invalidConfigPath = "error",
                    invalidTailwindDirective = "error",
                    recommendedVariantOrder = "warning",
                },
                classAttributes = {
                    "class",
                    "className",
                    "classList",
                    "ngClass",
                    ":class",
                },
            },
        },
        root_dir = lspconfig.util.root_pattern(
            "tailwind.config.js",
            "tailwind.config.ts",
            "tailwind.config.cjs",
            "tailwind.config.mjs",
            "postcss.config.js",
            "postcss.config.ts",
            "package.json",
            ".git"
        ),
    })
end

return M
