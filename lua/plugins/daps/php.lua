-- DAP configuration for php
local M = {}

M.setup = function()
    local dap = require("dap")

    -- PHP Debug Adapter Configuration
    dap.adapters.php = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/php-debug-adapter",
    }

    dap.configurations.php = {
        -- Local development
        {
            name = "Listen for Xdebug",
            type = "php",
            request = "launch",
            port = 9003, -- Default Xdebug 3 port (9000 for Xdebug 2)
            ignore = {
                "**/vendor/**/*.php",
            },
        },
    }
end

return M
