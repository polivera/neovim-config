-- Neovim main configuration file
require("config.options").init()
require("config.keymaps").init()
require("config.filetypes").init()
local lazy = require("config.lazy")
lazy.install()
lazy.load()

-- Move this to another file
vim.filetype.add({
    filename = {
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.override.yaml"] = "yaml.docker-compose",
        ["docker-compose.override.yml"] = "yaml.docker-compose",
    },
})
