return {
	preset = "modern",
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,
	filter = function(_)
		return true
	end,
	spec = {},
	notify = false,
	triggers = { { "<auto>", mode = "nixsotc" } },
	defer = function(ctx)
		return ctx.mode == "V" or ctx.mode == "<C-V>"
	end,
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = false, -- misc bindings to work with windows
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
	win = {
		no_overlap = true,
		height = { min = 3, max = 20 },
		border = "none",
		padding = { 1, 1 },
	},
	layout = {
		width = { min = 20, max = 50 },
		spacing = 15,
	},
	keys = {
		scroll_down = "<c-d>",
		scroll_up = "<c-u>",
	},
	sort = { "local", "order", "group", "alphanum", "mod" },
	expand = 0,
	icons = {
		breadcrumb = "",
		separator = "",
		group = " ",
		ellipsis = "…",
		mappings = true,
		rules = {},
		colors = true,
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			D = "󰘳 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "󰁮",
			Space = "󱁐 ",
			Tab = "󰌒 ",
			F1 = "󱊫",
			F2 = "󱊬",
			F3 = "󱊭",
			F4 = "󱊮",
			F5 = "󱊯",
			F6 = "󱊰",
			F7 = "󱊱",
			F8 = "󱊲",
			F9 = "󱊳",
			F10 = "󱊴",
			F11 = "󱊵",
			F12 = "󱊶",
		},
	},
	show_help = false,
	show_keys = false,
	disable = {
		ft = {},
		bt = {},
	},
	debug = false,
}
