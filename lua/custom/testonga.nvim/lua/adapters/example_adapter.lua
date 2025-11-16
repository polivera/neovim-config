-- Example adapter implementation demonstrating the interface pattern
local AdapterInterface = require("testonga.adapters_interface")

---@class ExampleAdapter : AdapterInterface
local ExampleAdapter = AdapterInterface:new({
    name = "example",
    filetypes = { "lua" }, -- Supported file types

    ---Get the command to run a test
    ---@param test_path string Path to the test file
    ---@param test_name? string Optional specific test name to run
    ---@return string command The command to execute
    get_test_command = function(self, test_path, test_name)
        if test_name then
            return string.format("busted %s --filter='%s'", test_path, test_name)
        else
            return string.format("busted %s", test_path)
        end
    end,

    ---Get the test function name at the current cursor position
    ---@param bufnr number Buffer number
    ---@param line number Line number (0-indexed)
    ---@return string? test_name The test name or nil if not found
    get_current_test = function(self, bufnr, line)
        -- Example implementation using treesitter or pattern matching
        -- This is simplified; you'd use treesitter in a real implementation
        local lines = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)
        if #lines > 0 then
            local test_match = lines[1]:match('it%("([^"]+)"')
            if test_match then
                return test_match
            end
            test_match = lines[1]:match("it%('([^']+)'")
            if test_match then
                return test_match
            end
        end
        return nil
    end,

    ---Get all tests in the given file
    ---@param bufnr number Buffer number
    ---@return table[] tests Array of test objects with {name: string, line: number}
    get_tests_in_file = function(self, bufnr)
        local tests = {}
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        for i, line in ipairs(lines) do
            local test_match = line:match('it%("([^"]+)"') or line:match("it%('([^']+)'")
            if test_match then
                table.insert(tests, {
                    name = test_match,
                    line = i - 1, -- 0-indexed
                })
            end
        end

        return tests
    end,

    ---Get the test file path for the current source file
    ---@param source_file string Path to the source file
    ---@return string? test_file_path Path to the test file or nil if pattern not matched
    get_test_file_path = function(self, source_file)
        -- Example: convert lua/mymodule.lua to spec/mymodule_spec.lua
        local base_name = source_file:match("([^/]+)%.lua$")
        if base_name then
            return string.format("spec/%s_spec.lua", base_name)
        end
        return nil
    end,

    ---Create a test file for the given source file
    ---@param source_file string Path to the source file
    ---@return string test_file_path Path to the created test file
    create_test_file = function(self, source_file)
        local test_file = self:get_test_file_path(source_file)
        if not test_file then
            error("Could not determine test file path for: " .. source_file)
        end

        -- Create directory if it doesn't exist
        local test_dir = test_file:match("(.+)/[^/]+$")
        if test_dir then
            vim.fn.mkdir(test_dir, "p")
        end

        -- Create basic test file template
        local template = string.format([[
describe("%s", function()
    it("should work", function()
        -- TODO: implement test
    end)
end)
]], source_file:match("([^/]+)%.lua$"))

        -- Write the file
        local file = io.open(test_file, "w")
        if file then
            file:write(template)
            file:close()
        end

        return test_file
    end,
})

return ExampleAdapter
