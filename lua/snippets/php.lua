local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Function to derive namespace from file path
-- Adjust the patterns below to match your project structure
local function get_namespace()
    local path = vim.fn.expand("%:p:h")

    -- Try common PSR-4 root directories
    -- Pattern: extracts everything after src/, app/, or lib/
    local namespace = path:match(".*/src/(.+)") or path:match(".*/app/(.+)") or path:match(".*/lib/(.+)")

    if namespace then
        -- Convert directory separators to namespace separators
        namespace = namespace:gsub("/", "\\")
        -- Capitalize first letter of each segment (optional, remove if not needed)
        namespace = namespace:gsub("(%w)([^\\]*)", function(first, rest)
            return first:upper() .. rest
        end)
        return "App\\" .. namespace
    end

    -- Fallback: use just "App" if no recognized structure
    return "App"
end

local function get_classname()
    return vim.fn.expand("%:t:r")
end

ls.add_snippets("php", {
    s("xapclass", {
        t({ "<?php", "", "declare(strict_types=1);", "", "namespace " }),
        f(get_namespace, {}),
        t({ ";", "", "", "final class " }),
        f(get_classname, {}),
        t({ "", "{", "    " }),
        i(0),
        t({ "", "}", "" }),
    }),
})
