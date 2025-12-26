local M = {
	columns = {
		"icon", -- keep the icon column
		"permissions",
		"size",
		"mtime",
	},
	default_file_explorer = true,
	skip_confirm_for_simple_edits = true,
	keymaps = {
		["<CR>"] = "actions.select",
		["<C-v>"] = "actions.select_vsplit",
		["<C-x>"] = "actions.select_split",
	},
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return name == ".." -- always hide the parent directory entry
		end,
	},
	prompt_save_on_select_new_entry = false,
	actions = {
		delete = {
			confirm = false,
		},
	},
	lsp_file_methods = {
		enabled = true,
	},
	win_options = {
		signcolumn = "yes:2",
	},
}

return M
