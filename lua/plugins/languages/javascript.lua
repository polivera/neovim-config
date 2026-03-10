-- LSP configuration for ts_ls
local M = {}

M.setup = function()
    local mason_registry = require("mason-registry")

    local plugins = {}

    -- Get path to Vue TypeScript plugin
    local vue_ok, vue_pkg = pcall(mason_registry.get_package, "vue-language-server")
    if vue_ok and vue_pkg:is_installed() then
        table.insert(plugins, {
            name = "@vue/typescript-plugin",
            location = vue_pkg:get_install_path() .. "/node_modules/@vue/language-server",
            languages = { "vue" },
        })
    end

    -- typescript-svelte-plugin ships inside svelte-language-server's node_modules
    local svelte_ok, svelte_pkg = pcall(mason_registry.get_package, "svelte-language-server")
    if svelte_ok and svelte_pkg:is_installed() then
        table.insert(plugins, {
            name = "typescript-svelte-plugin",
            location = svelte_pkg:get_install_path() .. "/node_modules/typescript-svelte-plugin",
            languages = { "svelte" },
        })
    end

    vim.lsp.config("ts_ls", {
        init_options = {
            plugins = plugins,
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
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    })
end

return M
