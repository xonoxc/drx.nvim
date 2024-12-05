local configs = {
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	autotag = {
		enable = true,
		filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "xml" },
	},
	indent = {
		enable = true,
		disable = {
			"python",
		},
	},
	addition_vim_regex_syntax_highlighting = { "python" },
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"php",
		"diff",
		"markdown",
		"regex",
		"toml",
		"yaml",
		"html",
		"jsdoc",
		"nu",
		"jsonc",
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
		"xml",
		"hyprlang",
		"http",
	},
	auto_install = true,
}

return configs
