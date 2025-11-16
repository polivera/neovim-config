-- Example adapter implementation demonstrating the interface pattern
local AdapterInterface = require("testonga.adapters_interface")

---@class PHPAdapter : AdapterInterface
local PHPAdapter = AdapterInterface:new({
    name = "php",
    filetypes = { "php" }, -- Supported file types

    ---Get the command to run a test
    ---@param test_path string Path to the test file
    ---@param test_name? string Optional specific test name to run
    ---@return string command The command to execute
    get_test_command = function(self, test_path, test_name)
        vim.nofify("get test command")
    end,

    ---Get the test function name at the current cursor position
    ---@param bufnr number Buffer number
    ---@param line number Line number (0-indexed)
    ---@return string? test_name The test name or nil if not found
    get_current_test = function(self, bufnr, line)
        vim.notify("get_current_test not implemented")
    end,

    ---Get all tests in the given file
    ---@param bufnr number Buffer number
    ---@return table[] tests Array of test objects with {name: string, line: number}
    get_tests_in_file = function(self, bufnr)
        vim.notify("get tests in file not implemented")
    end,

    ---Get the test file path for the current source file
    ---@param source_file string Path to the source file
    ---@return string? test_file_path Path to the test file or nil if pattern not matched
    get_test_file_path = function(self, source_file)
        vim.notify("get_test_file_path not implemented")
    end,

    ---Create a test file for the given source file
    ---@param source_file string Path to the source file
    ---@return string test_file_path Path to the created test file
    create_test_file = function(self, source_file)
        vim.notify("create test file not implemented")
    end,
})

return PHPAdapter
