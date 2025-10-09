-- lsp configuration for lua_ls
local m = {}

m.setup = function(lspconfig)
    local globals = require("config.globals")
    lspconfig.docker_compose_language_service.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        cmd = { "docker-compose-langserver", "--stdio" },
        root_dir = lspconfig.util.root_pattern(".git"),
        filetypes = { "yaml.docker-compose" },
    })
end

return m
