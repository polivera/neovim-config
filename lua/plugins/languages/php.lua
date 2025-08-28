-- LSP configuration for lua_ls
local globals = require("config.globals")
local M = {}

M.setup = function()
    vim.lsp.config("intelephense", {
        on_attach = globals.lsp_default_attach,
        settings = {
            intelephense = {
                files = {
                    maxSize = 5000000, -- 5MB
                    associations = { "*.php", "*.phtml", "*.inc", "*.module" },
                    exclude = {
                        "**/node_modules/**",
                        "**/vendor/**/Test/**",
                        "**/vendor/**/Tests/**",
                        "**/.git/**",
                        "**/storage/**",
                        "**/bootstrap/cache/**",
                    },
                },
                format = {
                    enable = true,
                    braces = "k&r", -- or "allman"
                },
                completion = {
                    insertUseDeclaration = true,
                    fullyQualifyGlobalConstantsAndFunctions = false,
                    suggestObjectOperatorStaticMethods = true,
                    triggerParameterHints = true,
                },
                diagnostics = {
                    enable = true,
                    run = "onType", -- or "onSave"
                    embeddedLanguages = true,
                },
                phpdoc = {
                    returnVoid = true,
                    textFormat = "snippet",
                },
                runtime = {
                    version = "8.2", -- Adjust to your PHP version
                },
                environment = {
                    includePaths = { "vendor" },
                },
            },
        },
    })
end

return M
