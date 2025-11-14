local M = {}

local function notify(message)
	vim.notify(message, vim.log.levels.INFO, { title = "PathInfo" })
end

local function get_relative_path()
	local bufpath = vim.fn.expand("%:p")
	if bufpath == "" then
		notify("No file open")
		return nil
	end
	local cwd = vim.fn.getcwd()
	return vim.fn.fnamemodify(bufpath, ":." .. cwd)
end

local function get_absolute_path()
	local bufpath = vim.fn.expand("%:p")
	if bufpath == "" then
		notify("No file open")
		return nil
	end
	return bufpath
end

local function get_git_remote_url()
	-- Try to get the git remote URL
	local handle = io.popen("git config --get remote.origin.url 2>/dev/null")
	if not handle then
		return nil
	end
	local result = handle:read("*a"):gsub("\n", "")
	handle:close()
	if result == "" then
		return nil
	end
	return result
end

local function git_remote_to_web_url(remote_url)
	-- Convert git remote URL to web URL
	-- Supports: https, ssh, and git protocols
	local url = remote_url

	-- Handle SSH URLs: git@github.com:user/repo.git -> https://github.com/user/repo
	url = url:gsub("git@([^:]+):(.*)", "https://%1/%2")

	-- Handle git protocol: git://github.com/user/repo.git -> https://github.com/user/repo
	url = url:gsub("^git://", "https://")

	-- Remove .git suffix
	url = url:gsub("%.git$", "")

	return url
end

local function get_vcs_url()
	local relative_path = get_relative_path()
	if not relative_path then
		return nil
	end

	local remote_url = get_git_remote_url()
	if not remote_url then
		notify("Not a git repository")
		return nil
	end

	local web_url = git_remote_to_web_url(remote_url)

	-- Get the branch name
	local branch_handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
	if not branch_handle then
		return web_url .. "/blob/main/" .. relative_path
	end
	local branch = branch_handle:read("*a"):gsub("\n", "")
	branch_handle:close()

	if branch == "" then
		branch = "main"
	end

	return web_url .. "/blob/" .. branch .. "/" .. relative_path
end

local function copy_to_clipboard(text)
	if not text then
		return
	end
	vim.fn.setreg("+", text)
	notify("Copied: " .. text)
end

M.setup = function()
	-- Setup function if needed
end

M.copy_relative_path = function()
	local path = get_relative_path()
	copy_to_clipboard(path)
end

M.copy_absolute_path = function()
	local path = get_absolute_path()
	copy_to_clipboard(path)
end

M.copy_vcs_url = function()
	local url = get_vcs_url()
	copy_to_clipboard(url)
end

return M
