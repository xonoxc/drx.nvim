local M = {}

function M.get_colors()
	local colors = {
		white = "#eeffff",
		darker_black = "#191919",
		black = "#212121", --  nvim bg
		black2 = "#292929",
		one_bg = "#303030",
		one_bg2 = "#383838",
		one_bg3 = "#404040",
		grey = "#4A4A4A",
		grey_fg = "#545454",
		grey_fg2 = "#5E5E5E",
		light_grey = "#6B6B6B",
		red = "#f07178",
		baby_pink = "#FFADFF",
		pink = "#DA70CA",
		line = "#383838", -- for lines like vertsplit
		green = "#c3e88d",
		vibrant_green = "#c3e88d",
		nord_blue = "#6e98eb",
		blue = "#82aaff",
		yellow = "#ffcb6b",
		sun = "#e6b455",
		purple = "#c792ea",
		dark_purple = "#b480d6",
		teal = "#abcf76",
		orange = "#f78c6c",
		cyan = "#89ddff",
		statusline_bg = "#262626",
		lightbg = "#323232",
		pmenu_bg = "#6e98eb",
		folder_bg = "#6e98eb",

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

		semantic_tokens = {
			["@lsp.type.annotation"] = { fg = colors.purple },
			["@lsp.type.class"] = { fg = colors.yellow },
			["@lsp.type.enum"] = { link = "@lsp.type.class" },
			["@lsp.type.enumMember"] = { link = "@lsp.type.property" },
			["@lsp.type.interface"] = { fg = colors.green, italic = false },
			["@lsp.type.method"] = { fg = colors.blue },
			["@lsp.type.modifier"] = { fg = colors.purple },
			["@lsp.type.namespace"] = { link = "@lsp.type.class" },
			["@lsp.type.parameter"] = { fg = colors.orange },
			["@lsp.type.property"] = { fg = colors.white },
			["@lsp.type.variable"] = { fg = colors.white },
			["@lsp.typemod.class.constructor"] = { link = "@lsp.type.method" },
			["@lsp.typemod.record"] = { link = "@lsp.type.class" },
		},

		telescope = {
			TelescopeMatching = { fg = colors.accent },
		},
	}

	return colors
end

return M
