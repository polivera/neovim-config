--- File type association configuration

local M = {}

M.init = function()
    vim.filetype.add({
        extension = {
            tf = "terraform",
            tfvars = "terraform",
            tfstate = "json",
        },
    })
end

return M
