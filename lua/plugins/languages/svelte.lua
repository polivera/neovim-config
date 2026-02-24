-- LSP configuration for Svelte
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.svelte.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = globals.get_capabilities(),
        on_new_config = function(new_config, new_root_dir)
            new_config.init_options = vim.tbl_deep_extend(
                "force",
                new_config.init_options or {},
                { typescript = { tsdk = new_root_dir .. "/node_modules/typescript/lib" } }
            )
        end,
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
