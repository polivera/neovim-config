-- Define options class. This will be passed as parameter to the setup function
---@class TestongaOptions
---@field adapters AdapterInterface[]

local M = {}

M.setup = function(opts)
    opts = opts or {}
    vim.inspect(opts)
    print("calling setup")
end

M.exec_current_test = function(_)
    print("execute test your cursor is currently on")
end

M.exec_current_file = function(_)
    print("Execute the current file")
end

M.list_current_file_tests = function(_)
    print("Get the tests of the currnet file")
end

M.open_current_file_test = function(_)
    print("open test of the current file")
end

M.create_test_for_current_file = function()
    print("Create a test for the current file")
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
