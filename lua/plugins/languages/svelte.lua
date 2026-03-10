-- LSP configuration for Svelte
local M = {}

M.setup = function()
    vim.lsp.config("svelte", {
        before_init = function(params, config)
            config.init_options = vim.tbl_deep_extend(
                "force",
                config.init_options or {},
                { typescript = { tsdk = params.rootPath .. "/node_modules/typescript/lib" } }
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
        root_markers = { "svelte.config.js", "svelte.config.ts", "package.json", ".git" },
    })
end

return M
