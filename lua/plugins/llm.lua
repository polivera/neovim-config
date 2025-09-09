return {
    "huggingface/llm.nvim",
    opts = {
        -- Backend configuration
        backend = "ollama",
        url = "http://192.168.0.123:11434",
        model = "codellama:7b",

        -- UI configuration - this is the key part for shadow text
        tokens_to_clear = { "<|endoftext|>" },
        fim = {
            enabled = true,
            prefix = "<PRE> ",
            middle = " <MID>",
            suffix = " <SUF>",
        },

        -- Completion behavior
        debounce_ms = 150,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<S-Tab>",
        tls_skip_verify_insecure = false,

        -- Auto-suggestions (like Copilot)
        context_window = 8192,
        enable_suggestions_on_startup = true,
    },
    keys = {
        {
            "<leader>ai",
            function()
                require("llm").toggle_auto_complete()
            end,
            desc = "Toggle AI auto-complete",
        },
        {
            "<leader>as",
            function()
                require("llm").suggest()
            end,
            desc = "Trigger AI suggestion",
        },
    },
}
