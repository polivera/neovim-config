-- Init file
vim.api.nvim_create_user_command("TestongaCurrent", function(opts)
    require("testonga").current(opts)
end, {
    nargs = 0,
    desc = "Command that takes no arguments",
})

-- last
-- file
-- select
