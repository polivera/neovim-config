local M = {}

M.install = function()
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
end

M.load = function()
    local globals = require("config.globals")
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        spec = {
            -- List of plugins here with the format { import = "package.path" },
            { import = "plugins.lsp" },
            { import = "plugins.treesitter" },
            { import = "plugins.completion" },
            { import = "plugins.snacks" },
            { import = "plugins.format" },
            { import = "plugins.oil" },
        },
        install = { colorscheme = { globals.colorscheme } },
        -- Automaticall checks for plugin updates
        checker = { enabled = false },
        dev = {
            path = vim.fn.stdpath("config") .. "/lua/custom/",
            fallback = false,
        },
    })
end

return M
