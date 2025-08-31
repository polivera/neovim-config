-- LSP configuration for PHP (intelephense)
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.intelephense.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
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
                    braces = "k&r",
                },
                completion = {
                    insertUseDeclaration = true,
                    fullyQualifyGlobalConstantsAndFunctions = false,
                    suggestObjectOperatorStaticMethods = true,
                    triggerParameterHints = true,
                },
                diagnostics = {
                    enable = true,
                    run = "onType",
                    embeddedLanguages = true,
                },
                phpdoc = {
                    returnVoid = true,
                    textFormat = "snippet",
                },
                environment = {
                    phpVersion = "8.3.0",
                    includePaths = { "vendor/" },
                },
            },
        },
    })
end

return M
