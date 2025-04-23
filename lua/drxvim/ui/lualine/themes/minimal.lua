local colors = {
	blue = "#569CD6",
	green = "#6A9955",
	red = "#D16969",
	yellow = "#DCDCAA",
	orange = "#CE9178",
	violet = "#C586C0",
	white = "#D4D4D4",
	light_gray = "#858585",
}

local minimal_theme = {
	normal = {
		a = { fg = colors.white, bg = "none", gui = "bold" },
		b = { fg = colors.light_gray, bg = "none" },
		c = { fg = colors.light_gray, bg = "none" },
	},
	insert = { a = { fg = colors.white, bg = "none", gui = "bold" } },
	visual = { a = { fg = colors.white, bg = "none", gui = "bold" } },
	replace = { a = { fg = colors.white, bg = "none", gui = "bold" } },
	inactive = {
		a = { fg = colors.light_gray, bg = "none" },
		b = { fg = colors.light_gray, bg = "none" },
		c = { fg = colors.light_gray, bg = "none" },
	},
}

local vim_icons = {
	function()
		return ""
	end,
	separator = { left = " ", right = " " },
	color = { bg = "none", fg = "#ccccccc" },
}

local mode = {
	"mode",
	fmt = function(str)
		return str:upper()
	end,
	color = function()
		local mode_color = {
			n = colors.blue,
			i = colors.green,
			v = colors.violet,
			[""] = colors.violet,
			V = colors.violet,
			c = colors.orange,
			r = colors.red,
			R = colors.red,
			t = colors.orange,
		}
		return { fg = colors.white, bg = mode_color[vim.fn.mode()] }
	end,
}

local branch = {
	"branch",
	icon = " ", -- Git branch icon
	color = { fg = colors.white, bg = "none" },
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = "+", modified = "~", removed = "-" },
	diff_color = {
		added = { fg = colors.white },
		modified = { fg = colors.white },
		removed = { fg = colors.white },
	},
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.yellow },
		info = { fg = colors.blue },
		hint = { fg = colors.green },
	},
}

local filename = {
	"filename",
	file_status = true,
	newfile_status = false,
	path = 0,
	shorting_target = 40,
	symbols = {
		modified = " ",
		readonly = " ",
		unnamed = " ",
		newfile = "󰝒 ",
	},
}

local filetype = {
	"filetype",
	color = { fg = colors.white, bg = "none" },
}

local fileformat = {
	"fileformat",
	symbols = {
		unix = " ",
		dos = " windows",
		mac = " osx",
	},
	color = { fg = colors.white, bg = "none" },
}

local location = {
	"location",
	separator = { left = " ", right = " " },
	color = { fg = "#cccccc", bg = colors.light_gray },
}

local progress = {
	"progress",
	icon = "󰔵 ",
}

local search_count = {
	function()
		local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
		local current = result.current
		local total = result.total
		if total > 0 then
			return current .. "/" .. total
		else
			return ""
		end
	end,
	color = { fg = colors.white, bg = "none" },
}

local lsp = {
	function()
		local msg = "no_active_client"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_clients()
		if not next(clients) then
			return msg
		end
		for _, client in ipairs(clients) do
			if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
				return client.name
			end
		end
		return msg
	end,
	icon = "",
	color = { fg = colors.light_gray, bg = "none" },
}

local formatter = function()
	local status, conform = pcall(require, "conform")
	if not status then
		return "Conform not installed"
	end

	local formatters = conform.list_formatters_for_buffer()
	if formatters and #formatters > 0 then
		return "󰷈 " .. formatters[1]
	end

	local lsp_format = require("conform.lsp_format")
	local bufnr = vim.api.nvim_get_current_buf()
	local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

	if lsp_clients and #lsp_clients > 0 then
		return " " .. lsp_clients[1].name --  is a gear icon
	end

	return ""
end

local virtual_env = function()
	if vim.bo.filetype ~= "python" then
		return ""
	end

	local conda_env = os.getenv("CONDA_DEFAULT_ENV")
	local venv_path = os.getenv("VIRTUAL_ENV")

	if venv_path == nil then
		if conda_env == nil then
			return ""
		else
			return string.format(" %s(conda)", conda_env)
		end
	else
		local venv_name = vim.fn.fnamemodify(venv_path, ":t")
		return string.format(" %s(venv)", venv_name)
	end
end

local py_virtual_env = {
	function()
		return virtual_env()
	end,
	separator = { left = " ", right = " " },
	color = { bg = "none", fg = "#ccccccc" },
}

local encoding = {
	"encoding",
	color = { fg = colors.white, bg = "none" },
}

local indent = {
	function()
		local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
		return "⇥ " .. shiftwidth
	end,
	color = { fg = colors.white, bg = "none" },
}

local progress_bar = {
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
		local line_ratio = current_line / total_lines
		local index = math.ceil(line_ratio * #chars)
		if index == 0 then
			index = 1
		end
		return chars[index]
	end,
	color = { fg = colors.green, bg = "none" },
}

local clock = {
	function()
		return os.date(" %H:%M")
	end,
	color = { fg = colors.light_gray, bg = "none" },
}

local spell = {
	function()
		if vim.wo.spell then
			return "󰓆"
		else
			return ""
		end
	end,
	color = { fg = colors.orange, bg = "none" },
}

local config = {
	options = {
		theme = minimal_theme,
		component_separators = "", -- No separators
		section_separators = "", -- No separators
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { vim_icons, mode },
		lualine_b = { branch, diff, spell },
		lualine_c = { diagnostics, filename, py_virtual_env, encoding },
		lualine_x = { formatter, lsp, filetype, fileformat, indent },
		lualine_y = { search_count, location },
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = { filename },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { location },
	},
	tabline = {},
	extensions = {},
}

return config
