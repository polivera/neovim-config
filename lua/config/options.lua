-- Neovim Options Configuration
-- A comprehensive set of options for a smooth Neovim experience

return {
    init = function()
        local options = {
            -- File Handling
            backup = false, -- Don't create backup files
            swapfile = false, -- Don't create swap files
            writebackup = false, -- Don't allow editing files being edited elsewhere
            undofile = true, -- Enable persistent undo history
            exrc = true, -- Allow project-specific .nvim.lua configuration files
            fileencoding = "utf-8", -- Default file encoding for new files
            hidden = true, -- Allow switching buffers without saving
            clipboard = "unnamedplus",

            -- Interface and Visual Settings
            cmdheight = 2, -- Taller command line for better message visibility
            pumheight = 20, -- Maximum number of items to show in popup menus
            showmode = false, -- Don't show mode indicator (INSERT/VISUAL) in command line
            laststatus = 3, -- Use global status line for all windows
            showtabline = 0, -- Always show the tab line (top)
            termguicolors = true, -- Use GUI colors in terminal (most terminals support this)
            guifont = "monospace:h17", -- Font for GUI Neovim clients
            cursorline = false, -- Don't highlight the current line
            colorcolumn = "120", -- Show column guideline at character 120
            wrap = false, -- Display long lines as a single line (no wrapping)
            linebreak = true, -- If wrap is enabled, break lines at word boundaries
            list = true, -- Show invisible characters
            listchars = { tab = "» ", trail = "·", nbsp = "␣" }, -- Symbols for invisible characters
            lazyredraw = false, -- Don't redraw screen during macros (performance boost)
            ttyfast = true,

            -- Line Numbers
            number = true, -- Show line numbers
            relativenumber = true, -- Show relative line numbers for easier motion
            numberwidth = 4, -- Width of the line number column
            signcolumn = "yes", -- Always show sign column to prevent text shifting

            -- Scrolling Behavior
            scrolloff = 8, -- Minimum lines to keep above/below cursor when scrolling
            sidescrolloff = 8, -- Minimum columns to keep left/right of cursor when scrolling horizontally
            smoothscroll = true, -- Smooth scrolling for horizontal movement (Neovim 0.10+)

            -- Indentation and Tabs
            expandtab = true, -- Convert tabs to spaces
            shiftwidth = 4, -- Number of spaces for each indentation level
            tabstop = 4, -- Number of spaces a tab counts for
            smartindent = true, -- Smart auto-indenting when starting a new line

            -- Search Behavior
            hlsearch = false, -- Don't highlight all matches from previous search
            ignorecase = true, -- Ignore case in search patterns
            smartcase = true, -- Override ignorecase if search contains uppercase
            incsearch = true, -- Show search results as you type

            -- Command Line Completion
            wildmenu = true, -- Enhanced command-line completion
            wildmode = "longest,list,full", -- Complete longest common string, then list alternatives, then full match

            -- Mouse Support
            mouse = "a", -- Enable mouse in all modes

            -- Code Folding
            foldmethod = "indent", -- Fold code based on indentation levels
            foldlevelstart = 99, -- Start with all folds open

            -- Timing Settings
            timeoutlen = 200, -- Time to wait for mapped sequence to complete (ms)
            ttimeoutlen = 10, -- Time to wait for key code sequence to complete (ms)
            updatetime = 100, -- Time before triggering CursorHold event (ms)

            -- Completion Options
            completeopt = { "menuone", "noselect", "noinsert" }, -- Completion menu behavior
            pumblend = 10, -- Popup menu transparency
            winblend = 10, -- Window transparency

            -- Window Splitting Behavior
            splitbelow = true, -- Horizontal splits go below current window
            splitright = true, -- Vertical splits go to the right of current window

            -- Diff Mode Improvements
            diffopt = vim.opt.diffopt + { "algorithm:patience", "indent-heuristic" }, -- Better diff algorithm

            -- Markdown Settings
            conceallevel = 0, -- Don't hide markdown syntax characters

            -- Virtual Editing
            virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode

            -- ############ New Improvements? ############ --
            -- Performance and memory
            maxmempattern = 20000, -- Increase memory for pattern matching
            synmaxcol = 300, -- Only highlight syntax up to column 300
            redrawtime = 1500, -- Time limit for redrawing

            -- File handling improvements
            autoread = true, -- Automatically read file changes
            confirm = true, -- Ask for confirmation instead of failing

            -- Security
            modeline = false, -- Disable modeline for security

            -- Formatting
            textwidth = 0, -- Don't auto-wrap text
            wrapmargin = 0, -- Don't auto-wrap based on margin

            -- Undo settings
            undolevels = 10000, -- Maximum number of undo levels

            -- Better command line
            shortmess = vim.opt.shortmess + { W = true, I = true, c = true, C = true },
        }

        -- Apply all options
        for k, v in pairs(options) do
            vim.opt[k] = v
        end
    end,
}
