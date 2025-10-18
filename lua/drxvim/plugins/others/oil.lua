local M = {
	columns = {
		"icon", -- keep the icon column
		"permissions",
		"size",
		"mtime",
	},
	default_file_explorer = false,
	skip_confirm_for_simple_edits = true,
	keymaps = {
		["<CR>"] = "actions.select",
		["<C-v>"] = "actions.select_vsplit",
		["<C-x>"] = "actions.select_split",
	},
	view_options = {
		show_hidden = true,
	},
	win_options = {
		signcolumn = "no",
	},
}

return M
