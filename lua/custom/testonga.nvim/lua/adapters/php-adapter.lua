-- Example adapter implementation demonstrating the interface pattern
local AdapterInterface = require("adapters-interface")

---@class PHPAdapter : AdapterInterface
local PHPAdapter = AdapterInterface:new({
    name = "php",
    filetypes = { "php" }, -- Supported file types

    ---Get the command to run a test
    ---@param test_path string Path to the test file
    ---@param test_name? string Optional specific test name to run
    ---@return string command The command to execute
    get_test_command = function(self, test_path, test_name)
        -- Use vendor/bin/phpunit if available, otherwise fall back to phpunit
        local phpunit_cmd = vim.fn.filereadable("vendor/bin/phpunit") == 1 and "vendor/bin/phpunit" or "phpunit"

        if test_name then
            return string.format("%s --filter='%s' %s", phpunit_cmd, test_name, test_path)
        else
            return string.format("%s %s", phpunit_cmd, test_path)
        end
    end,

    ---Get the test function name at the current cursor position
    ---@param bufnr number Buffer number
    ---@param line number Line number (0-indexed)
    ---@return string? test_name The test name or nil if not found
    get_current_test = function(self, bufnr, line)
        -- Search backwards from current line to find the test method
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        for i = line + 1, 1, -1 do
            if lines[i] then
                -- Match PHPUnit test methods: public function testSomething() or test_Something()
                -- Also match: /** @test */ public function something()
                local method_match = lines[i]:match("function%s+(test[_a-zA-Z0-9]+)%s*%(")
                if method_match then
                    return method_match
                end

                -- Check if there's a @test annotation above
                local has_test_annotation = lines[i]:match("@test")
                if has_test_annotation then
                    -- Look for the function on the next lines
                    for j = i + 1, math.min(i + 5, #lines) do
                        local func_match = lines[j]:match("function%s+(%w+)%s*%(")
                        if func_match then
                            return func_match
                        end
                    end
                end
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
        local has_test_annotation = false

        for i, line in ipairs(lines) do
            -- Check for @test annotation
            if line:match("@test") then
                has_test_annotation = true
            end

            -- Match test methods: public function testSomething() or test_Something()
            local method_match = line:match("function%s+(test[_a-zA-Z0-9]+)%s*%(")
            if method_match then
                table.insert(tests, {
                    name = method_match,
                    line = i - 1, -- 0-indexed
                })
                has_test_annotation = false
            elseif has_test_annotation then
                -- If we had a @test annotation, check for any public function
                local func_match = line:match("function%s+(%w+)%s*%(")
                if func_match then
                    table.insert(tests, {
                        name = func_match,
                        line = i - 1, -- 0-indexed
                    })
                    has_test_annotation = false
                end
            end
        end

        return tests
    end,

    ---Get the test file path for the current source file
    ---@param source_file string Path to the source file
    ---@return string? test_file_path Path to the test file or nil if pattern not matched
    get_test_file_path = function(self, source_file)
        -- Common PHP test patterns:
        -- 1. src/Foo.php -> tests/FooTest.php
        -- 2. app/Models/User.php -> tests/Unit/Models/UserTest.php or tests/Feature/Models/UserTest.php
        -- 3. lib/Bar.php -> tests/BarTest.php

        -- Extract the file name without extension
        local file_name = source_file:match("([^/]+)%.php$")
        if not file_name then
            return nil
        end

        -- Try pattern: src/* -> tests/*Test.php
        local src_path = source_file:match("src/(.+)%.php$")
        if src_path then
            return string.format("tests/%sTest.php", src_path)
        end

        -- Try pattern: app/* -> tests/Unit/* or tests/Feature/*
        local app_path = source_file:match("app/(.+)%.php$")
        if app_path then
            -- Check if Unit test exists first
            local unit_test = string.format("tests/Unit/%sTest.php", app_path)
            if vim.fn.filereadable(unit_test) == 1 then
                return unit_test
            end
            -- Otherwise try Feature test
            local feature_test = string.format("tests/Feature/%sTest.php", app_path)
            if vim.fn.filereadable(feature_test) == 1 then
                return feature_test
            end
            -- Default to Unit if neither exists
            return unit_test
        end

        -- Try pattern: lib/* -> tests/*Test.php
        local lib_path = source_file:match("lib/(.+)%.php$")
        if lib_path then
            return string.format("tests/%sTest.php", lib_path)
        end

        -- Fallback: just append Test to the filename in a tests directory
        return string.format("tests/%sTest.php", file_name)
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

        -- Extract class name from source file
        local class_name = source_file:match("([^/]+)%.php$")
        local test_class_name = class_name .. "Test"

        -- Try to extract namespace from source file
        local namespace = ""
        local source_content = vim.fn.readfile(source_file)
        for _, line in ipairs(source_content) do
            local ns = line:match("^namespace%s+([^;]+)")
            if ns then
                -- Convert src namespace to test namespace
                namespace = ns:gsub("^App", "Tests\\Unit"):gsub("^Src", "Tests")
                break
            end
        end

        -- Create basic PHPUnit test template
        local template = string.format(
            [[<?php

namespace %s;

use PHPUnit\Framework\TestCase;

class %s extends TestCase
{
    public function testExample(): void
    {
        $this->assertTrue(true);
    }
}
]],
            namespace,
            test_class_name
        )

        -- Write the file
        local file = io.open(test_file, "w")
        if file then
            file:write(template)
            file:close()
        else
            error("Failed to create test file: " .. test_file)
        end

        return test_file
    end,
})

return PHPAdapter
