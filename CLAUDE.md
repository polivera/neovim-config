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
│   ├── globals.lua  # Shared functions (LSP attach handler, capabilities, colorscheme)
│   └── filetypes.lua # File type associations
├── plugins/          # Plugin specifications (lazy.nvim format)
│   ├── languages/   # Language-specific LSP configs
│   └── daps/        # Debug adapter configs (go, php, python)
├── mylib/           # Shared utility library (buffer helpers, async command runner)
├── snippets/        # LuaSnip snippet files per language (e.g. snippets/php.lua)
└── custom/          # Local plugin development (dev path for lazy.nvim)
    ├── testonga.nvim/  # Test runner plugin
    └── pathinfo.nvim/  # Path info plugin
after/
└── ftplugin/        # File-type-specific overrides (lua, javascript, yaml, markdown)
```

### Plugin Management Pattern
All plugins use lazy.nvim specs. Active plugins are explicitly listed in `lua/config/lazy.lua`. Several plugins are currently commented out (snacks, blink, neotest, gen, avante, llm, codecompanion, obsidian) — to enable one, uncomment its line in the `spec` table.

Each plugin file in `lua/plugins/` returns either a single spec table or an array of related specs.

Common lazy-loading triggers: `event = "VeryLazy"`, `keys = {...}`, `lazy = false` (immediate load)

### LSP Configuration Pattern
LSP setup uses the native `vim.lsp.config()` / `vim.lsp.enable()` API (Neovim 0.11+):
- `lua/plugins/lsp.lua` - Orchestrator that sets global LSP config via `vim.lsp.config('*', ...)`, calls each language module's `.setup()`, and calls `vim.lsp.enable(...)` for all servers
- `lua/plugins/languages/*.lua` - Individual language modules, each exports a `.setup()` function that calls `vim.lsp.config('server_name', {...})`
- `lua/config/globals.lua` - Exports:
  - `lsp_default_attach(_, bufnr)` - Sets buffer-local LSP keymaps; applied globally via `vim.lsp.config('*')`
  - `get_capabilities()` - Merges blink.cmp capabilities with default LSP capabilities; applied globally via `vim.lsp.config('*')`

When adding a new language server:
1. Create `lua/plugins/languages/LANGUAGE.lua` with a `.setup()` function that calls `vim.lsp.config('server_name', {...})` with server-specific settings (on_attach and capabilities are inherited from the wildcard config)
2. Call the setup function from `lua/plugins/lsp.lua`
3. Add the server name to the `vim.lsp.enable({...})` list in `lsp.lua`
4. Add the server name and any formatters/linters to mason-tool-installer's `ensure_installed` list in `lsp.lua`

### DAP Configuration Pattern
Debug adapters follow the same coordinator pattern as LSP:
- `lua/plugins/dap.lua` - Sets up nvim-dap, dap-ui, keymaps, and calls each language DAP module
- `lua/plugins/daps/*.lua` - Individual language debug adapter configs, each exports `.setup()`

### Formatter Configuration
Formatting is handled by conform.nvim (`lua/plugins/format.lua`). Format-on-save is enabled. Each formatter is configured with explicit command/args — check this file when adding or changing formatting behavior for a language.

### mylib Utility Library
`lua/mylib/` provides shared utilities importable as `require("mylib")`:
- `mylib.buffer` - Buffer path helpers (`get_relative_path`, `get_absolute_path`, `get_git_remote_url`, `get_current_line_number`, `get_filetype`)
- `mylib.cmd` - Async command runner (`run_command(cmd, opts)`) using `vim.fn.jobstart` with `on_line`/`on_exit` callbacks

### Custom Plugin Development
The `lua/custom/` directory is configured as the dev path for lazy.nvim. Set `dev = true` in a plugin spec to use the local version from `lua/custom/PLUGIN_NAME/`.

## Key Conventions

### Leader Key Mappings
- `<leader>` is Space
- `<leader>f*` - Find/picker operations (snacks.picker or telescope)
- `<leader>l*` - LSP operations (defined in `globals.lsp_default_attach`)
- `<leader>o*` - Git operations (Neogit, Gitsigns, Diffview)
- `<leader>d*` - Debugger (nvim-dap)
- `<leader>x` - Trouble diagnostics
- `<leader>w` / `<leader>q` / `<leader>Q` - Save / close buffer / quit all
- `<leader>an` / `<leader>aq` - New tab / close tab

### Custom Register Behavior
The configuration rewires default Vim keys:
- `m` = cut (deletes and yanks to default register)
- `d` = delete without yanking (black hole register `"_d`)
- `c` = change without yanking (`"_c`)
- `x` = delete char without yanking (`"_x`)
- `v` paste = `"_dP` (doesn't overwrite register when pasting in visual mode)

This means `y`/`Y` is the only way to yank intentionally. When writing new keymaps that involve deletion, be aware of this remapping.

### Module Pattern
Core config files use:
```lua
local M = {}
M.init = function() ... end
return M
```

Plugin language/DAP files use:
```lua
local M = {}
M.setup = function() ... end
return M
```

## Working with This Config

### Testing Configuration Changes
After editing config files, reload Neovim or use `:source %` on the current file. For plugin changes, use `:Lazy reload PLUGIN_NAME` or restart Neovim.

### Adding Plugins
1. Create `lua/plugins/PLUGIN_NAME.lua` returning a lazy.nvim spec
2. Add `{ import = "plugins.PLUGIN_NAME" }` to the `spec` table in `lua/config/lazy.lua`

### Debugging LSP Issues
- Use `:LspInfo` to check attached servers
- LSP keybindings are defined in `lua/config/globals.lua` in `lsp_default_attach`
- LSP servers are auto-installed via mason-tool-installer (configured in `lua/plugins/lsp.lua`)

### Snippets
LuaSnip snippets are in `lua/snippets/LANGUAGE.lua`. They must be explicitly loaded by a plugin that calls `require("snippets.LANGUAGE")`.

### File Type Specific Settings
Override settings per file type in `after/ftplugin/FILETYPE.lua` (standard Neovim convention). Existing overrides: lua, javascript, yaml, markdown.
