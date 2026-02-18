# Keymap Rules

- All plugin keymaps with descriptions must use `which-key` (`wk.add(...)`) so they appear in the popup. Raw `vim.keymap.set` is acceptable only for mappings with no description or defined outside a plugin config.
- New `<leader>` bindings must respect existing namespace prefixes:
  - `f` → find/picker
  - `l` → LSP
  - `o` → git
  - `d` → debugger
  - `x` → diagnostics
  - `w` → buffer/window ops
  - `a` → tabs
  Don't claim a prefix for something semantically unrelated.
- Never use `d`, `c`, `x`, or `X` as the action key in a new mapping — they are remapped to the black hole register. Use `m` (cut) when you need to yank-and-delete.
- `<C-g>` is escape in insert/visual/select mode — don't rebind it.
- `<C-p>` is bound to the tmux sessionizer — don't rebind it.
