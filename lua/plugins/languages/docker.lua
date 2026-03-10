-- LSP configuration for dockerls
local m = {}

m.setup = function()
    vim.lsp.config("dockerls", {
        cmd = { "docker-language-server", "start", "--stdio" },
        root_markers = { ".git" },
        filetypes = { "Dockerfile", "dockerfile" },
    })
end

return m
