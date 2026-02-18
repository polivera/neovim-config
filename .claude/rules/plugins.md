# Plugin Rules

- Every new plugin must have its own file in `lua/plugins/`. Do not add plugin specs inline in `lua/config/lazy.lua`.
- To temporarily disable a plugin, comment out its `{ import = ... }` line in `lua/config/lazy.lua`. Do not delete the plugin file.
- Use `lazy = false` only when a plugin genuinely must load at startup. Prefer `event`, `keys`, or `ft` triggers.
- Local/experimental plugins go in `lua/custom/PLUGIN_NAME/` with `dev = true` in the spec; their spec file goes in `lua/plugins/PLUGIN_NAME.lua` as normal.
- Several plugins are currently disabled (commented out in `lazy.lua`): snacks, blink, neotest, gen, avante, llm, codecompanion, obsidian. Do not re-enable them unless explicitly asked.
- Formatters and linters are configured in `lua/plugins/format.lua` (conform.nvim) and `lua/plugins/lint.lua`. Add new ones there, not inside language files.
