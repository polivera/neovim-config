# Code Style Rules

- Config modules (`lua/config/`) expose an `init()` function. Language and DAP modules expose a `setup()` function. Keep these consistent.
- All modules follow the table pattern:
  ```lua
  local M = {}
  M.init = function() ... end  -- or M.setup
  return M
  ```
- Use `lua/mylib/` utilities (`mylib.buffer`, `mylib.cmd`) instead of duplicating buffer-path or async-command logic in individual plugins.
- Snippets belong in `lua/snippets/LANGUAGE.lua` and must be required explicitly — do not scatter snippet definitions inside plugin config files.
- File-type-specific overrides (`vim.opt_local`, `vim.bo`) belong in `after/ftplugin/FILETYPE.lua`, not inside plugin configs or `options.lua`.
- Keep each plugin file focused on a single plugin (or a tightly related group). Do not combine unrelated plugins into one file.
