-- Define options class. This will be passed as parameter to the setup function
---@class TestongaOptions
---@field adapters AdapterInterface[]

local M = {}

M.setup = function(opts)
    opts = opts or {}
    print("calling setup")
end

M.current = function(_)
    print("Exec Current")
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
