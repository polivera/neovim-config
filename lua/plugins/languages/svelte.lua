-- LSP configuration for Svelte
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.svelte.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = globals.get_capabilities(),
        settings = {
            svelte = {
                plugin = {
                    html = { completions = { enable = true, emmet = false } },
                    svelte = { defaultScriptLanguage = "ts" },
                },
            },
        },
        root_dir = lspconfig.util.root_pattern("svelte.config.js", "svelte.config.ts", "package.json", ".git"),
    })
end

return M
