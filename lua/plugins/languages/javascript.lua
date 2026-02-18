-- LSP configuration for ts_ls
local M = {}

M.setup = function(lspconfig)
    local globals = require("config.globals")
    local mason_registry = require("mason-registry")

    -- Get path to Vue TypeScript plugin
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"

    -- typescript-svelte-plugin ships inside svelte-language-server's node_modules
    local svelte_plugin_path = mason_registry.get_package("svelte-language-server"):get_install_path()
        .. "/node_modules/typescript-svelte-plugin"

    lspconfig.ts_ls.setup({
        on_attach = globals.lsp_default_attach,
        capabilities = globals.get_capabilities(),
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vue_language_server_path,
                    languages = { "vue" },
                },
                {
                    name = "typescript-svelte-plugin",
                    location = svelte_plugin_path,
                    languages = { "svelte" },
                },
            },
        },
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
            "templ",
        },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    })
end

return M
