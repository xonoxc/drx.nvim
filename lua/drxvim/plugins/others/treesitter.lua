local configs = {
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	autotag = {
		enable = true,
		filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "xml" },
	},
	indent = { enable = true },
	ensure_installed = {
		"lua",
		"python",
		"fish",
		"bash",
		"typescript",
		"javascript",
		"go",
		"json",
		"tsx",
		"graphql",
	},
}

return configs
