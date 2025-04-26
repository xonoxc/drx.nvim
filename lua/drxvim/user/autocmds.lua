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

-- setting .env.* filetype for all types of env files
autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = ".env*",
	command = "set filetype=sh",
})

-- detecting bun.lock file as jsonc file
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "bun.lock",
	callback = function()
		vim.cmd("setfiletype jsonc")
	end,
	desc = "set bun.lock file to jsonc",
})

-- detecting the header files

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.h",
	callback = function()
		vim.cmd("setfiletype c")
	end,
	desc = "Set Filetype c for Header Files",
})

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "tsconfig.json",
	callback = function()
		vim.cmd("setfiletype json")
	end,
	desc = "setting tsconfig.json as a json file",
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

		require("drxvim.themes").load()
	end,
	desc = "Reload neovim config on save",
})

local function center_cursor()
	local current_pos = vim.fn.getpos(".")
	vim.cmd("normal! zz")
	vim.fn.setpos(".", current_pos)
end

-- Set up the autocommand
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	pattern = "*",
	callback = center_cursor,
})

-- Create custom command to Create Custom Config
vim.api.nvim_create_user_command("DrxvimCreateCustom", function()
	vim.cmd("lua require('drxvim.user.functions').CreateCustom()")
end, {})

-- settting html django filetype when encountering any html file in python venv

local function set_html_django_filetype()
	local venv = os.getenv("VIRTUAL_ENV")
	if venv and vim.fn.filereadable(venv .. "/bin/activate") == 1 then
		vim.bo.filetype = "htmldjango"
	end
end

autocmd({ "BufReadPost" }, {
	pattern = "*.html",
	callback = set_html_django_filetype,
})

--  formatting for templ files
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.templ" },
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Config for PYTHON files for python files

vim.opt_local.autoindent = true
vim.opt_local.smarttab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.textwidth = 80

-- Set the indent after opening parenthesis
vim.g.pyindent_open_paren = vim.bo.shiftwidth

-- Automatically make the current string an f-string when typing `{`.
vim.api.nvim_create_autocmd("InsertCharPre", {
	pattern = { "*.py" },
	group = vim.api.nvim_create_augroup("py-fstring", { clear = true }),
	callback = function(params)
		if vim.v.char ~= "{" then
			return
		end

		local node = vim.treesitter.get_node({})

		if not node then
			return
		end

		if node:type() ~= "string" then
			node = node:parent()
		end

		if not node or node:type() ~= "string" then
			return
		end
		local row, col, _, _ = vim.treesitter.get_node_range(node)
		local first_char = vim.api.nvim_buf_get_text(params.buf, row, col, row, col + 1, {})[1]
		if first_char == "f" or first_char == "r" then
			return
		end

		vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<esc>`'la")
	end,
})

-- converthing the string to template string in js and ts files
vim.api.nvim_create_autocmd("TextChangedI", {
	pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
	group = vim.api.nvim_create_augroup("js-ts-template-string", { clear = true }),
	callback = function(params)
		local cursor_pos = vim.api.nvim_win_get_cursor(0)
		local row, col = cursor_pos[1] - 1, cursor_pos[2]

		local node = vim.treesitter.get_node({})

		if not node then
			return
		end

		if node:type() ~= "string" then
			node = node:parent()
		end

		if not node or node:type() ~= "string" then
			return
		end

		local start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(node)

		local text = vim.api.nvim_buf_get_text(params.buf, start_row, start_col, end_row, end_col, {})[1]

		if text:find("%${") and not text:match("^`") then
			vim.api.nvim_buf_set_text(params.buf, start_row, start_col, start_row, start_col + 1, { "`" })
			vim.api.nvim_buf_set_text(params.buf, end_row, end_col - 1, end_row, end_col, { "`" })

			vim.api.nvim_win_set_cursor(0, { row + 1, col + 1 })
		end
	end,
})
