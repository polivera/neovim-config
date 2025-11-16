-- Buffer helper functions
local M = {}

M.get_buffer_filetype = function(bufnr)
    bufnr = bufnr or 0 -- default to current buffer
    return vim.bo[bufnr].filetype
end

return M
