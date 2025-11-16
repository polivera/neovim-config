-- adapter_interface.lua
---@class AdapterInterface
---@field name string The adapter name
---@field filetypes string[] Supported filetypes
local AdapterInterface = {}
AdapterInterface.__index = AdapterInterface

---Create a new adapter instance
---@param impl table Implementation table with required methods
---@return AdapterInterface
function AdapterInterface:new(impl)
    impl = impl or {}

    -- Validate required fields
    assert(impl.name, "Adapter must have a 'name' field")
    assert(impl.filetypes, "Adapter must have a 'filetypes' field")
    assert(type(impl.filetypes) == "table", "filetypes must be a table/array")

    -- Validate required methods
    local required_methods = {
        "get_test_command",
        "get_current_test",
        "get_tests_in_file",
        "get_test_file_path",
        "create_test_file",
    }

    for _, method in ipairs(required_methods) do
        assert(
            type(impl[method]) == "function",
            string.format("Adapter '%s' must implement method: %s", impl.name or "unknown", method)
        )
    end

    setmetatable(impl, self)
    return impl
end

---Get the command to run a test
---@param test_path string Path to the test file
---@param test_name? string Optional specific test name to run
---@return string command The command to execute
function AdapterInterface:get_test_command(test_path, test_name)
    error(string.format("Method 'get_test_command' must be implemented by adapter '%s'", self.name))
end

---Get the test function name at the current cursor position
---@param bufnr number Buffer number
---@param line number Line number (0-indexed)
---@return string? test_name The test name or nil if not found
function AdapterInterface:get_current_test(bufnr, line)
    error(string.format("Method 'get_current_test' must be implemented by adapter '%s'", self.name))
end

---Get all tests in the given file
---@param bufnr number Buffer number
---@return table[] tests Array of test objects with {name: string, line: number}
function AdapterInterface:get_tests_in_file(bufnr)
    error(string.format("Method 'get_tests_in_file' must be implemented by adapter '%s'", self.name))
end

---Get the test file path for the current source file
---@param source_file string Path to the source file
---@return string? test_file_path Path to the test file or nil if pattern not matched
function AdapterInterface:get_test_file_path(source_file)
    error(string.format("Method 'get_test_file_path' must be implemented by adapter '%s'", self.name))
end

---Create a test file for the given source file
---@param source_file string Path to the source file
---@return string test_file_path Path to the created test file
function AdapterInterface:create_test_file(source_file)
    error(string.format("Method 'create_test_file' must be implemented by adapter '%s'", self.name))
end

---Check if this adapter supports the given filetype
---@param filetype string Filetype to check
---@return boolean
function AdapterInterface:supports_filetype(filetype)
    for _, ft in ipairs(self.filetypes) do
        if ft == filetype then
            return true
        end
    end
    return false
end

return AdapterInterface
