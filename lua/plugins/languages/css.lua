-- LSP configuration for cssls
local m = {}

m.setup = function()
    vim.lsp.config("cssls", {
        root_markers = { "package.json", ".git" },
        filetypes = { "css", "templ" },
        settings = {
            css = {
                validate = true,
            },
        },
    })
end

return m
