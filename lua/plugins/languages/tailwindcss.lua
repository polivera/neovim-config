-- LSP configuration for Tailwind CSS
local M = {}

M.setup = function()
    vim.lsp.config("tailwindcss", {
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
        root_markers = {
            "tailwind.config.js",
            "tailwind.config.ts",
            "tailwind.config.cjs",
            "tailwind.config.mjs",
            "postcss.config.js",
            "postcss.config.ts",
            "package.json",
            ".git",
        },
    })
end

return M
