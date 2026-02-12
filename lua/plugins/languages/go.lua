-- LSP configuration for gopls
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")

    lspconfig.gopls.setup({
        on_attach = function(client, bufnr)
            globals.lsp_default_attach(client, bufnr)

            -- Organize imports on save (synchronous)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    local params = vim.lsp.util.make_range_params()
                    params.context = { only = { "source.organizeImports" } }
                    local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
                    for _, res in pairs(result or {}) do
                        for _, action in pairs(res.result or {}) do
                            if action.edit then
                                vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                            elseif action.command then
                                vim.lsp.buf.execute_command(action.command)
                            end
                        end
                    end
                end,
            })
        end,
        settings = {
            gopls = {
                buildFlags = { "-tags=unit,integration,wireinject" },
                gofumpt = true,
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    })
end

return M
