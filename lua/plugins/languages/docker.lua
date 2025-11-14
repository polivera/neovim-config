-- lsp configuration for lua_ls
local m = {}

m.setup = function(lspconfig)
    local globals = require("config.globals")
    lspconfig.dockerls.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = globals.get_capabilities(),
        cmd = { "docker-language-server", "start", "--stdio" },
        root_dir = lspconfig.util.root_pattern(".git"),
        filetypes = { "Dockerfile", "dockerfile" },
    })
end

return m
