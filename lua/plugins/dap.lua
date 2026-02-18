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
            render = {
                max_value_lines = 100,
            },
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.4 },
                        { id = "breakpoints", size = 0.2 },
                        { id = "stacks", size = 0.2 },
                        { id = "watches", size = 0.2 },
                    },
                    position = "left",
                    size = 40,
                },
                {
                    elements = {
                        { id = "console", size = 0.6 },
                        { id = "repl", size = 0.4 },
                    },
                    position = "bottom",
                    size = 12,
                },
            },
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    pause = "⏸",
                    play = "▶",
                    step_into = "⏎",
                    step_over = "⏭",
                    step_out = "⏮",
                    step_back = "B",
                    run_last = "▶▶",
                    terminate = "⏹",
                    disconnect = "⏏",
                },
            },
            floating = {
                max_height = nil,
                max_width = 0.5, -- Use 50% of screen width
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            force_buffers = true,
        })

        -- Automatically open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        -- launch.json loader (type_to_filetypes maps DAP adapter name → filetypes)
        local vscode = require("dap.ext.vscode")
        local launch_filetypes = { delve = { "go" }, go = { "go" }, python = { "python" }, php = { "php" } }
        local function load_launch_json()
            local path = vim.fn.getcwd() .. "/.vscode/launch.json"
            if vim.fn.filereadable(path) == 1 then
                pcall(vscode.load_launchjs, path, launch_filetypes)
                vim.notify("launch.json loaded", vim.log.levels.INFO)
            else
                vim.notify("No .vscode/launch.json found in " .. vim.fn.getcwd(), vim.log.levels.WARN)
            end
        end
        load_launch_json()

        -- DAP keymaps
        wk.add({
            { "<leader>d", group = "Debugger" },
            { "<leader>do", dap.continue, desc = " Start/Continue" },
            { "<leader>dn", dap.step_over, desc = " Step Over" },
            { "<leader>di", dap.step_into, desc = " Step Into" },
            { "<leader>du", dap.step_out, desc = " Step Out" },
            { "<leader>db", dap.toggle_breakpoint, desc = " Toggle Breakpoint" },
            { "<leader>dl", load_launch_json, desc = "Reload launch.json" },
            { "<leader>dr", dap.repl.open, desc = "Open Repl" },
            { "<leader>dq", dapui.close, desc = "Close DAP ui" },
            { "<leader>df", dapui.float_element, desc = "Float element" },
            { "<leader>de", dapui.eval, desc = "Eval" },
        })

        -- Setup virtual text to show variable values inline
        require("nvim-dap-virtual-text").setup({})

        vim.fn.sign_define("DapBreakpoint", {
            text = "🔴", -- Red circle emoji
            texthl = "DapBreakpoint",
            linehl = "",
            numhl = "",
        })

        vim.fn.sign_define("DapStopped", {
            text = "👉", -- Pointing finger
            texthl = "DapStopped",
            linehl = "DapStoppedLine",
            numhl = "DapStopped",
        })

        -- Set custom colors for better visibility
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" }) -- Bright red
        vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f79000" }) -- Orange
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00f000" }) -- Bright green
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2a3a2a" }) -- Dark green background
        vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#888888" }) -- Gray

        -- Custom language configuration
        require("plugins.daps.php").setup()
        require("plugins.daps.go").setup()
        require("plugins.daps.python").setup()
    end,
}
