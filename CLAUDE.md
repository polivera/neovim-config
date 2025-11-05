# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Neovim configuration using lazy.nvim as the plugin manager. The configuration is modular, 
with clear separation between core settings, plugin specifications, and language-specific configurations.

## Architecture

### Entry Point & Initialization Order
The configuration loads in this sequence (`init.lua`):
1. `require("config.options").init()` - Apply editor settings
2. `require("config.keymaps").init()` - Set up global keybindings
3. `require("config.filetypes").init()` - Register file type associations
4. `require("config.lazy")` - Bootstrap and load all plugins

### Directory Structure
```
lua/
├── config/           # Core configuration modules
│   ├── lazy.lua     # Plugin manager bootstrap & loading
│   ├── options.lua  # Neovim settings (vim.opt)
│   ├── keymaps.lua  # Global keybindings
│   ├── globals.lua  # Shared functions and values (LSP attach handler)
│   └── filetypes.lua # File type associations
├── plugins/          # Plugin specifications (lazy.nvim format)
│   ├── languages/   # Language-specific LSP configs
│   └── daps/        # Debug adapter configs
└── custom/          # Local plugin development (dev path for lazy.nvim)
```

### Plugin Management Pattern
All plugins use lazy.nvim specs. Plugins are imported via:
```lua
spec = {
    { import = "plugins.treesitter" },
    { import = "plugins.lsp" },
    -- etc.
}
```

Each plugin file in `lua/plugins/` returns either:
- A single plugin spec table
- An array of related plugin specs

Common lazy-loading triggers: `event = "VeryLazy"`, `keys = {...}`, `lazy = false` (immediate load)

### LSP Configuration Pattern
LSP setup follows a coordinator pattern:
- `lua/plugins/lsp.lua` - Main orchestrator that loads language-specific configs
- `lua/plugins/languages/*.lua` - Individual language modules with `.setup(lspconfig)` function
- `lua/config/globals.lua` - Exports `lsp_default_attach(bufnr)` used by all language servers

When adding a new language server:
1. Create `lua/plugins/languages/LANGUAGE.lua` with a `.setup(lspconfig)` function
2. Import and call it in `lua/plugins/lsp.lua`
3. Use `globals.lsp_default_attach` for consistent LSP keybindings
4. Add the server name to mason-tool-installer's `ensure_installed` list

### Custom Plugin Development
The `lua/custom/` directory is configured as the dev path for lazy.nvim. The testonga.nvim plugin demonstrates the pattern:
- Plugin spec in `lua/plugins/testonga.lua`
- Source code in `lua/custom/testonga.nvim/`
- Set `dev = true` in the plugin spec to use local version

## Key Conventions

### Leader Key Mappings
- `<leader>` is Space
- `<leader>f*` - Find/Telescope operations
- `<leader>l*` - LSP operations (defined in globals.lsp_default_attach)
- `<leader>o*` - Git operations
- `<leader>d*` - Debugger
- `<leader>a*` - AI/CodeCompanion
- `<leader>x` - Trouble diagnostics

### Custom Register Behavior
The configuration rewires default Vim keys:
- `m` = cut (deletes and yanks)
- `d` = delete without yanking (black hole register)
- `c` = change without yanking
This workflow preserves the default register for intentional yank operations.

### Module Pattern
Core config files use this pattern:
```lua
local M = {}
M.init = function()
    -- setup code
end
return M
```

## Working with This Config

### Testing Configuration Changes
After editing config files, reload Neovim or use `:source %` on the current file. For plugin changes, use `:Lazy reload PLUGIN_NAME` or restart Neovim.

### Adding Plugins
1. Create a new file in `lua/plugins/PLUGIN_NAME.lua`
2. Return a lazy.nvim spec table
3. The plugin will be auto-imported on next restart
4. Use `:Lazy` to manage plugins interactively

### Debugging LSP Issues
- Use `:LspInfo` to check attached servers
- LSP keybindings are defined in `lua/config/globals.lua` in the `lsp_default_attach` function
- LSP servers are auto-installed via mason-tool-installer
- Check language-specific config in `lua/plugins/languages/`

### File Type Specific Settings
Override settings per file type in `after/ftplugin/FILETYPE.lua` (standard Neovim convention)
