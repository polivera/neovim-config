-- Init file
vim.api.nvim_create_user_command("TestongaCurrentTest", function(opts)
    require("testonga").exec_current_test(opts)
end, {
    nargs = 0,
    desc = "Command that takes no arguments",
})

vim.api.nvim_create_user_command("TestongaCurrentFile", function(opts)
    require("testonga").exec_current_file(opts)
end, {
    nargs = 0,
    desc = "Run all the test on current file test",
})

vim.api.nvim_create_user_command("TestongaListFileTests", function(opts)
    require("testonga").list_current_file_test(opts)
end, {
    nargs = 0,
    desc = "Run all the test on current file test",
})
