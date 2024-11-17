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

-- local encoding = {
-- 	"encoding",
-- 	color = { fg = colors.white, bg = "none" },
-- }

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
		local clients = vim.lsp.get_active_clients()
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

local config = {
	options = {
		theme = minimal_theme,
		component_separators = "", -- No separators
		section_separators = "", -- No separators
		disabled_filetypes = {}, -- Specify filetypes to exclude if needed
	},
	sections = {
		lualine_a = { vim_icons, mode },
		lualine_b = { branch, diff },
		lualine_c = { diagnostics, filename },
		lualine_x = { lsp, filetype, fileformat, progress },
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
