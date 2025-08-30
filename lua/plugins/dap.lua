---@diagnostic disable: missing-fields
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local wk = require("which-key")

        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    pause = "⏸",
                    play = "▶",
                    step_into = "⏎",
                    step_over = "⏭",
                    step_out = "⏮",
                    step_back = "b",
                    run_last = "▶▶",
                    terminate = "⏹",
                    disconnect = "⏏",
                },
            },
        })

        -- Automatically open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        -- DAP keymaps
        wk.add({
            { "<leader>d", group = "Debugger" },
            { "<leader>do", dap.continue, desc = " Start/Continue" },
            { "<leader>dn", dap.step_over, desc = " Step Over" },
            { "<leader>di", dap.step_into, desc = " Step Into" },
            { "<leader>du", dap.step_out, desc = " Step Out" },
            { "<leader>db", dap.toggle_breakpoint, desc = " Toggle Breakpoint" },
            { "<leader>dr", dap.repl.open, desc = "Open Repl" },
            { "<leader>dq", dapui.close, desc = "Close DAP ui" },
            { "<leader>df", dapui.float_element, desc = "Float element" },
            { "<leader>de", dapui.eval, desc = "Eval" },
        })

        -- Setup virtual text to show variable values inline
        require("nvim-dap-virtual-text").setup({})

        -- Custom language configuration
        require("plugins.daps.php").setup()
    end,
}
