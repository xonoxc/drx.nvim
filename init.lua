require("drxvim.user")

--- @diagnostic disable warning
local function echo(str)
	vim.cmd("redraw")
	vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	echo("Hi there, welcome to DRXVIM 󱠡 ")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.mouse = "nvi"
vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({
	extension = {
		jinja = "jinja",
		jinja2 = "jinja",
		j2 = "jinja",
	},
})
vim.filetype.add({
	filename = {
		[".prettierignore"] = "prettier",
		[".prettierrc"] = "prettier",
	},
})
vim.filetype.add({
	pattern = { [".*/hyprland%.conf"] = "hyprlang" },
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
vim.opt.rtp:prepend(lazypath)
require("drxvim.plugins")
require("drxvim.cmd.cmd")
