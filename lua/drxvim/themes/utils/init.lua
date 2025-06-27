return {
	apply_highlight_overrides = function(hl_table)
		for group, opts in pairs(hl_table or {}) do
			vim.api.nvim_set_hl(0, group, opts)
		end
	end,
}
