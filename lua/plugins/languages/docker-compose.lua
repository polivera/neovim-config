-- LSP configuration for docker-compose
local m = {}

m.setup = function()
    vim.lsp.config("docker_compose_language_service", {
        cmd = { "docker-compose-langserver", "--stdio" },
        root_markers = { ".git" },
        filetypes = { "yaml.docker-compose" },
    })
end

return m
