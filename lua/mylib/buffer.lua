-- Buffer helper functions
local M = {}

M.get_filetype = function(bufnr)
    bufnr = bufnr or 0 -- default to current buffer
    return vim.bo[bufnr].filetype
end

M.get_relative_path = function()
    local bufpath = vim.fn.expand("%:p")
    if bufpath == "" then
        return nil
    end
    local cwd = vim.fn.getcwd()
    return vim.fn.fnamemodify(bufpath, ":." .. cwd)
end

M.get_absolute_path = function()
    local bufpath = vim.fn.expand("%:p")
    if bufpath == "" then
        return nil
    end
    return bufpath
end

M.get_git_remote_url = function()
    local handle = io.popen("git config --get remote.origin.url 2>/dev/null")
    if not handle then
        return nil
    end
    local result = handle:read("*a"):gsub("\n", "")
    handle:close()
    if result == "" then
        return nil
    end
    return result
end

M.get_current_line_number = function()
    return vim.fn.line(".")
end

return M
