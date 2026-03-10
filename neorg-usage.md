# Neorg Usage Summary

Neorg is an organization and note-taking plugin for Neovim, similar to Emacs Org-mode. It uses its own `.norg` file format with treesitter-based parsing.

## Setup

- **Default workspace**: `~/notes` (configured as the `notes` workspace)
- **Completion**: Integrated with nvim-cmp
- **Concealer**: Enabled for prettier rendering of markup
- **Summary**: Module enabled for generating workspace summaries

## Norg File Format Basics

### Headings

```norg
* Heading 1
** Heading 2
*** Heading 3
```

### Lists

```norg
- Unordered item
- Another item
  - Nested item

~ Ordered item
~ Second item
```

### TODO Items

```norg
- ( ) Undone
- (x) Done
- (-) Pending
- (=) On hold
- (_) Cancelled
- (!) Urgent
- (+) Recurring
```

### Links

```norg
{:path/to/file:}           -- Link to another .norg file
{* Heading}                 -- Link to a heading in current file
{:file:* Heading}           -- Link to heading in another file
{https://example.com}       -- External URL
```

### Text Markup

```norg
*bold*
/italic/
_underline_
-strikethrough-
`inline code`
^superscript^
,subscript,
```

### Code Blocks

```norg
@code lua
print("hello")
@end
```

## Key Commands

| Command | Description |
|---|---|
| `:Neorg workspace notes` | Switch to the notes workspace |
| `:Neorg index` | Open the workspace index file |
| `:Neorg return` | Close all Neorg buffers and return |
| `:Neorg journal today` | Open today's journal entry |
| `:Neorg journal yesterday` | Open yesterday's journal entry |
| `:Neorg journal tomorrow` | Open tomorrow's journal entry |

## Default Keybindings (in .norg buffers)

| Key | Mode | Description |
|---|---|---|
| `<CR>` | Normal | Follow link / toggle TODO |
| `<Tab>` | Normal | Next heading / cycle TODO state |
| `<S-Tab>` | Normal | Previous heading |
| `<C-Space>` | Normal | Toggle TODO checkbox |
| `>>` | Normal | Promote heading/list |
| `<<` | Normal | Demote heading/list |
| `<leader>nn` | Normal | New note (if dirman keybinds enabled) |

## Workspace Structure

```
~/notes/
├── index.norg          # Main entry point
├── journal/            # Daily journal entries
│   └── 2026/
│       └── 03/
│           └── 10.norg
└── ...                 # Your organized notes
```

## Tips

- Run `:Neorg index` to open or create the workspace index file as your starting point
- Use `:Neorg journal today` for daily journaling
- Link between notes using `{:filename:}` syntax for a personal wiki
- The concealer module renders markup symbols as unicode characters for a cleaner view
- `conceallevel` is set to 2 in `.norg` files for full concealment
