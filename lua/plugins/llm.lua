return {
    "huggingface/llm.nvim",
    opts = {
        backend = "ollama",
        url = "http://127.0.0.1:11434",
        model = "codellama:7b-code",

        tokens_to_clear = { "" },
        fim = {
            enabled = true,
            prefix = "▁<PRE>",
            middle = "▁<MID>",
            suffix = "▁<SUF>",
        },

        debounce_ms = 150,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<S-Tab>",
        tls_skip_verify_insecure = false,

        context_window = 4096,
        enable_suggestions_on_startup = true,

        request_body = {
            options = {
                temperature = 0.2,
                top_p = 0.95,
                num_predict = 64,
            },
        },
    },
    keys = {
        {
            "<leader>ai",
            "<cmd>LLMToggleAutoSuggest<cr>",
            desc = "Toggle AI auto-complete",
        },
        {
            "<leader>as",
            "<cmd>LLMSuggestion<cr>",
            desc = "Trigger AI suggestion",
        },
    },
}
