local M = {}

function M.get_colors()
	local colors = {
		-- AMOLED base
		black = "#000000", -- pure black
		black2 = "#0a0a0a",
		one_bg = "#0d0d0d",
		one_bg2 = "#121212",
		one_bg3 = "#1a1a1a",

		-- Neutral grays/whites
		grey = "#2a2a2a",
		grey_fg = "#3a3a3a",
		grey_fg2 = "#444444",
		light_grey = "#555555",
		white = "#f2f4f8",
		light_white = "#d0d0d0",
		subtle_white = "#b0b0b0",

		-- Minimal accents
		accent = "#33b1ff", -- single main accent (blue/cyan)
		string_color = "#be95ff", -- strings (muted magenta)
		red = "#e05278", -- softer red
		green = "#3fa86f", -- softer green

		-- UI
		line = "#1a1a1a",
		statusline_bg = "#0a0a0a",
		lightbg = "#141414",
		pmenu_bg = "#1e1e1e",
		folder_bg = "#33b1ff",
		none = "NONE",

		-- Base16 minimal
		base00 = "#000000",
		base01 = "#0d0d0d",
		base02 = "#141414",
		base03 = "#1a1a1a",
		base04 = "#2a2a2a",
		base05 = "#d0d0d0",
		base06 = "#f2f4f8",
		base07 = "#ffffff",
		base08 = "#e05278", -- red
		base09 = "#33b1ff", -- blue accent
		base0A = "#be95ff", -- strings
		base0B = "#3fa86f", -- green (diff add)
		base0C = "#33b1ff", -- cyan/blue
		base0D = "#33b1ff", -- functions/keywords
		base0E = "#be95ff", -- types
		base0F = "#e05278", -- alt red
	}

	colors.polish_hl = {
		syntax = {
			Normal = { fg = colors.white },
			Identifier = { fg = colors.light_white }, -- variables
			Keyword = { fg = colors.accent }, -- blue
			Conditional = { fg = colors.accent }, -- same as keyword
			Function = { fg = colors.accent }, -- unify functions/keywords
			String = { fg = colors.string_color }, -- subtle magenta
			Comment = { fg = colors.grey_fg, italic = false },
			Constant = { fg = colors.light_white },
		},
		diff = {
			DiffAdd = { fg = colors.green },
			DiffDelete = { fg = colors.red },
			DiffChange = { fg = colors.accent },
		},
	}

	return colors
end

return M
