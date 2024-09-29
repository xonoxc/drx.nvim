local colors = {
	blue = "#80a0ff",
	cyan = "#79d340",
	skin = "#f96e74",
	black = "#080808",
	white = "#c6c6c6",
	red = "#ff5189",
	violet = "#d183e8",
	grey = "#000000",
	light_gray = "#cccccc",
	orange = "#fec54d",
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

local modes = {
	"mode",
	fmt = function(str)
		return str
	end,
	color = { bg = "#fab387", fg = "#000000" },
	separator = { left = "", right = "" },
}

local diff = {
	"diff",
	icon = " ",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.light_gray },
		modified = { fg = colors.light_gray },
		removed = { fg = colors.light_gray },
	},
	separator = { left = "", right = "" },
}

local vim_icons = {
	function()
		return ""
	end,
	separator = { left = "", right = "" },
	color = { bg = "#fab387", fg = "#000000" },
}

local branch = {
	"branch",
	icon = " ",
	separator = { left = "", right = "" },
	color = { bg = colors.blue, fg = "#000000" },
}

local lsp = {
	function()
		local msg = "inactive"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = "󰒋",
	color = { fg = colors.light_gray, gui = "bold" },
}

local file_format = {
	"fileformat",
	separator = { left = "", right = "" },
	color = { bg = "#dddddd", fg = "#000000" },
}

local location = {
	"location",
	icon = "",
	left_padding = 1,
	right_padding = 1,
	color = { bg = colors.violet, fg = "#000000" },
	separator = { left = "", right = "" },
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

local progress = {
	"progress",
	icon = "󰔵 ",
}

local filetype = {
	"filetype",
	color = { bg = "#fab387", fg = "#000000" },
	padding = { left = 1, right = 1 },
	separator = { left = "", right = "" },
}

local config = {
	options = {
		theme = bubbles_theme,
		component_separators = "",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { vim_icons, modes },
		lualine_b = { filename, branch, diff },
		lualine_c = {},
		lualine_x = { file_format, lsp },
		lualine_y = { filetype, progress, location },
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = { "", "" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
}

return config
