local M = {}

function M.get_colors()
	local colors = {
		white = "#c0caf5",
		darker_black = "#1b1e2b",
		black = "#1e222e",
		black2 = "#252935",
		one_bg = "#2a2e3f",
		one_bg2 = "#363b4f",
		one_bg3 = "#3e4358",
		grey = "#495162",
		grey_fg = "#545b70",
		grey_fg2 = "#5f677d",
		light_grey = "#6b7385",
		red = "#f7768e",
		baby_pink = "#DE8C92",
		pink = "#ff75a0",
		line = "#32364a",
		green = "#9ece6a",
		vibrant_green = "#73daca",
		nord_blue = "#80a8fd",
		blue = "#7aa2f7",
		yellow = "#e0af68",
		sun = "#EBCB8B",
		purple = "#bb9af7",
		dark_purple = "#9d7cd8",
		teal = "#1abc9c",
		orange = "#ff9e64",
		cyan = "#7dcfff",
		statusline_bg = "#22263a",
		lightbg = "#2f3447",
		pmenu_bg = "#7aa2f7",
		folder_bg = "#7aa2f7",

		-- base colors
		base00 = "#212121",
		base01 = "#292929",
		base02 = "#303030",
		base03 = "#383838",
		base04 = "#404040",
		base05 = "#DFF0F0",
		base06 = "#E6F7F7",
		base07 = "#eeffff",
		base08 = "#b0bec5",
		base09 = "#f78c6c",
		base0A = "#ffcb6b",
		base0B = "#c3e88d",
		base0C = "#c3e88d",
		base0D = "#82aaff",
		base0E = "#c792ea",
		base0F = "#f07178",
	}

	colors.polish_hl = {
		treesitter = {
			["@attribute"] = { fg = colors.purple },
			["@conditional.ternary"] = { fg = colors.cyan },
			["@constant"] = { fg = colors.yellow },
			["@constant.builtin"] = { link = "@constant" },
			["@constructor"] = { fg = colors.cyan },
			["@delimiter"] = { fg = colors.pink },
			["@keyword.exception"] = { fg = colors.purple },
			["@variable.member"] = { fg = colors.white },
			["@function"] = { fg = colors.blue },
			["@function.macro"] = { fg = colors.pale_blue },
			["@keyword"] = { fg = colors.cyan },
			["@module"] = { fg = colors.yellow },
			["@operator"] = { fg = colors.cyan },
			["@parenthesis"] = { link = "@punctuation.bracket" },
			["@punctuation.bracket"] = { fg = colors.pink },
			["@punctuation.delimiter"] = { fg = colors.pink },
			["@keyword.repeat"] = { fg = colors.purple },
			["@string"] = { fg = colors.green },
			-- ["@type"] = { fg = colors.yellow },
			["@type.qualifier"] = { fg = colors.cyan },
			-- ["@variable.type"] = { fg = colors.yellow },
		},

		syntax = {
			Identifier = { fg = colors.white },
			Include = { fg = colors.purple },
			Number = { fg = colors.orange },
			Structure = { fg = colors.green },
			Type = { fg = colors.purple },
		},
	}

	return colors
end

return M
