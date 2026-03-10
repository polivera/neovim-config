-- LSP configuration for terraformls
local m = {}

m.setup = function()
    vim.lsp.config("terraformls", {
        root_markers = { ".terraform", ".git", "terraform.tf" },
        filetypes = { "terraform", "terraform-vars" },
        settings = {
            terraform = {
                format = {
                    enable = true,
                },
                validation = {
                    enable = true,
                },
            },
        },
    })
end

return m
