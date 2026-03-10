-- LSP configuration for PHP (intelephense)
local M = {}

M.setup = function()
    vim.lsp.config("intelephense", {
        init_options = {
            licenceKey = os.getenv("INTELEPHENSE_KEY"),
        },
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
