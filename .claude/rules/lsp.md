# Language Server Rules

- Always use `globals.lsp_default_attach` as the `on_attach` callback for every LSP server — never define a custom `on_attach` that bypasses it.
- Always pass `globals.get_capabilities()` as `capabilities` to every LSP server so completion (blink.cmp) integrates correctly.
- Every server name added to a language file must also be added to `ensure_installed` in mason-tool-installer (`lua/plugins/lsp.lua`). Formatters and linters installed via mason go there too.
- Never configure LSP keybindings inside a language file — they belong exclusively in `globals.lsp_default_attach`.
- Each language module lives in `lua/plugins/languages/LANGUAGE.lua`, exports a single `M.setup(lspconfig)` function, and is called from `lua/plugins/lsp.lua`.
- When adding a new DAP adapter, mirror the same pattern: create `lua/plugins/daps/LANGUAGE.lua` with `M.setup()` and call it from `lua/plugins/dap.lua`.
