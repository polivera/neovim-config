-- LSP configuration for html
local m = {}

m.setup = function()
    vim.lsp.config("html", {
        root_markers = { "package.json", ".git" },
        filetypes = { "html", "templ" },
        settings = {
            css = {
                validate = true,
            },
        },
    })
end

return m
