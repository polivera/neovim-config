# Language Server Rules

- LSP servers are configured using the native `vim.lsp.config()` / `vim.lsp.enable()` API (Neovim 0.11+). Do NOT use `require('lspconfig').server.setup()`.
- Global `on_attach` and `capabilities` are set via `vim.lsp.config('*', ...)` in `lua/plugins/lsp.lua` — language files should NOT set these unless they need to override the default (e.g., Go wraps `on_attach` for import organization).
- Use `root_markers = { ... }` instead of `lspconfig.util.root_pattern(...)` for workspace root detection.
- Every server name added to a language file must also be added to `vim.lsp.enable({...})` and to `ensure_installed` in mason-tool-installer (`lua/plugins/lsp.lua`). Formatters and linters installed via mason go in `ensure_installed` too.
- Never configure LSP keybindings inside a language file — they belong exclusively in `globals.lsp_default_attach`.
- Each language module lives in `lua/plugins/languages/LANGUAGE.lua`, exports a single `M.setup()` function that calls `vim.lsp.config('server_name', {...})`, and is called from `lua/plugins/lsp.lua`.
- When adding a new DAP adapter, mirror the same pattern: create `lua/plugins/daps/LANGUAGE.lua` with `M.setup()` and call it from `lua/plugins/dap.lua`.
