-- Neovim main configuration file
require("config.options").init()
require("config.keymaps").init()
local lazy = require("config.lazy")
lazy.install()
lazy.load()
