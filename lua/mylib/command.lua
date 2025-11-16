local M = {}

M.run_command = function(cmd, opts)
    opts = opts or {}
    local on_line = opts.on_line
    local on_exit = opts.on_exit

    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data, _)
            if data and #data > 0 then
                if data[#data] == "" then
                    table.remove(data)
                end
                if on_line then
                    for _, line in ipairs(data) do
                        on_line(line, "stdout")
                    end
                end
            end
        end,
        on_stderr = function(_, data, _)
            if data and #data > 0 then
                if on_line then
                    for _, line in ipairs(data) do
                        on_line(line, "stderr")
                    end
                end
            end
        end,
        on_exit = function(_, exit_code, _)
            if on_exit then
                on_exit(exit_code)
            end
        end,
    })
end

return M
