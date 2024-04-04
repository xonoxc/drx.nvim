local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "UIEnter" }, {
	callback = function()
		require("drxvim.themes").load()
		if vim.fn.argc() == 0 then
			require("drxvim.ui.tedash").setup()
		end
	end,
	desc = "Load Statusline, Dashboard and Themes",
})
autocmd({ "BufNewFile", "BufReadPost" }, {
	callback = function()
		require("drxvim.ui.tebufline").setup()
	end,
	desc = "Load TabBufline",
})

-- detecting the header files

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.h",
	callback = function()
		vim.cmd("setfiletype c")
	end,
	desc = "Set Filetype c for Header Files",
})


autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float({ scope = "cursor", focusable = false })
	end,
	desc = "Open Float Window for LSP Diagnostics",
})

autocmd("TextYankPost", {
	group = augroup("yank_highlight", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yanked text",
})



autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
		vim.cmd("startinsert")
	end,
	desc = "Disable number and cursorline in terminal",
})

autocmd({ "FileType" }, {
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"fugitive",
		"git",
		"gitcommit",
		"help",
		"lazy",
		"lspinfo",
		"man",
		"mason",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function()
		vim.opt.number = false
		vim.opt_local.cursorline = false
	end,
	desc = "Disable number and cursorline",
})

autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
	desc = "Don't list quickfix buffer",
})

autocmd("BufWritePost", {
	pattern = "*/lua/*",
	callback = function(opts)
		local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r")
		local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
		local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")
		vim.cmd("silent source %")

		require("plenary.reload").reload_module("drxvim.themes")
		require("plenary.reload").reload_module(module)
		require("plenary.reload").reload_module("custom")

		require("plenary.reload").reload_module("drxvim.ui.tebufline")
		vim.opt.tabline = "%!v:lua.require('drxvim.ui.tebufline').getTabline()"

		require("plenary.reload").reload_module("drxvim.ui.testtline")
		vim.opt.statusline = "%!v:lua.require('drxvim.ui.testtline').setup()"

		require("drxvim.themes").load()
	end,
	desc = "Reload neovim config on save",
})

-- Create custom command to Create Custom Config
vim.api.nvim_create_user_command("DrxvimCreateCustom", function()
	vim.cmd("lua require('drxvim.user.functions').CreateCustom()")
end, {})
