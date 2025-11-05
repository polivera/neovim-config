-- Obsidian.nvim configuration
-- @see https://github.com/epwalsh/obsidian.nvim

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "Studies",
                path = "~/Projects/Personal/vaults/vault-studies/",
            },
            {
                name = "Personal",
                path = "~/Projects/Personal/vaults/vault-personal/",
            },
            {
                name = "Work",
                path = "~/Projects/Personal/vaults/vault-work/",
            },
        },

        note_id_func = function(title)
            -- If title is provided, use it as the filename
            if title ~= nil then
                -- Convert to lowercase and replace spaces with hyphens
                return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If no title, use timestamp
                return tostring(os.date("%Y%m%d%H%M%S"))
            end
        end,

        disable_frontmatter = false,

        -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },

        -- Where to put new notes
        notes_subdir = "notes",

        -- Daily notes configuration
        daily_notes = {
            folder = "daily",
            date_format = "%Y-%m-%d",
            alias_format = "%B %-d, %Y",
            template = nil,
        },

        -- Optional, configure additional syntax highlighting / extmarks.
        ui = {
            enable = true,
            update_debounce = 200,
            checkboxes = {
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
                [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
            },
            bullets = { char = "•", hl_group = "ObsidianBullet" },
            external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            reference_text = { hl_group = "ObsidianRefText" },
            highlight_text = { hl_group = "ObsidianHighlightText" },
            tags = { hl_group = "ObsidianTag" },
            hl_groups = {
                ObsidianTodo = { bold = true, fg = "#f78c6c" },
                ObsidianDone = { bold = true, fg = "#89ddff" },
                ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
                ObsidianTilde = { bold = true, fg = "#ff5370" },
                ObsidianBullet = { bold = true, fg = "#89ddff" },
                ObsidianRefText = { underline = true, fg = "#c792ea" },
                ObsidianExtLinkIcon = { fg = "#c792ea" },
                ObsidianTag = { italic = true, fg = "#89ddff" },
                ObsidianHighlightText = { bg = "#75662e" },
            },
        },

        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        use_advanced_uri = false,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = false,

        -- Optional, by default commands like `:ObsidianSearch` will attempt to use
        -- telescope.nvim, fzf-lua, and fzf.vim (in that order), and use the
        -- first one they find. You can set this option to tell obsidian.nvim to always use this
        -- finder.
        finder = "telescope.nvim",

        -- Optional, configure key mappings for the finder. These are the defaults.
        finder_mappings = {
            new = "<C-x>",
        },

        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        sort_by = "modified",
        sort_reversed = true,

        -- Optional, determines how certain commands open notes.
        open_notes_in = "current",

        -- Optional, configure additional callbacks
        callbacks = {
            -- Runs after creating a new note
            post_setup = function(client) end,

            -- Runs when entering a note buffer
            enter_note = function(client, note) end,

            -- Runs when leaving a note buffer
            leave_note = function(client, note) end,

            -- Runs after creating a new note
            post_create = function(client, note) end,
        },
    },

    keys = {
        { "<leader>bn", "<cmd>ObsidianNew<cr>", desc = "New note" },
        { "<leader>bo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
        { "<leader>bq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
        { "<leader>bf", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
        { "<leader>bb", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
        { "<leader>bt", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
        { "<leader>bd", "<cmd>ObsidianToday<cr>", desc = "Open today's note" },
        { "<leader>by", "<cmd>ObsidianYesterday<cr>", desc = "Open yesterday's note" },
        { "<leader>bw", "<cmd>ObsidianWorkspace<cr>", desc = "Switch workspace" },
        { "<leader>bl", "<cmd>ObsidianLink<cr>", desc = "Link selection", mode = "v" },
        { "<leader>bL", "<cmd>ObsidianLinkNew<cr>", desc = "Link new note", mode = "v" },
        { "<leader>br", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
    },
}
