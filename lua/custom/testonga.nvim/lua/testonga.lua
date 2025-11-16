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
    local bftype = util.buffer.get_filetype()
    local foo = adapters[bftype]:get_current_test(0, util.buffer.get_current_line_number())
    vim.notify(foo)
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

-- Functions that we need
-- Get cmd to run test command
-- Get current test function
-- Get a list of test in file
-- Get test file for current file
-- Create test file for current file?
--
-- For all this we need adapters, so we can create specialize clases for each

return M
