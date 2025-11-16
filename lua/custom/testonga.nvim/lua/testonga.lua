-- Define options class. This will be passed as parameter to the setup function
---@class TestongaOptions
---@field adapters AdapterInterface[]

local M = {}
local util = require("mylib")
local adapters = {
    php = require("adapters.php-adapter"),
}

M.setup = function(opts)
    opts = opts or {}
    vim.inspect(opts)
end

M.exec_current_test = function(_)
    local adapter = adapters[util.buffer.get_filetype()] or nil
    if adapter == nil then
        vim.notify("Adapter not found")
        return
    end
    local test_name = adapter:get_current_test(0, util.buffer.get_current_line_number())
    local test_file_path = util.buffer.get_absolute_path()
    if test_file_path == nil then
        return
    end
    local test_command = adapter:get_test_command(test_file_path, test_name)
    vim.notify(test_command)
end

M.exec_current_file = function(_)
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.list_current_file_tests = function(_)
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.open_current_file_test = function(_)
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.create_test_for_current_file = function()
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

M.repeat_last_test = function()
    local bftype = util.buffer.get_filetype()
    -- adapters[bftype].get_current_test()
end

return M
