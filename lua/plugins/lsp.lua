-- LSP Configuration

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.languages.lua").setup()
        end,
    },
    { "mason-org/mason.nvim", opts = {} },
    { "mason-org/mason-lspconfig.nvim", opts = {} },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = { "lua_ls", "stylua" },
        },
    },
}
