-- adapter_interface.lua
---@class AdapterInterface
---@field name string The adapter name
---@field filetypes string[] Supported filetypes
local AdapterInterface = {}

---Setup the adapter with configuration
---@param opts table Configuration options
---@return nil
function AdapterInterface:setup(opts) end
