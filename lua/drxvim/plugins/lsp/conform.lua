return {
	formatters_by_ft = {

		lua = { "stylua" },
		php = {
			"pretty-php",
		},
		typescript = {
			{
				"prettierd",
			},
		},
		svelte = {
			{
				"prettierd",
			},
		},
		typescriptreact = {
			{
				"prettierd",
			},
		},
		yaml = {
			"yamlfix",
		},
		javascriptreact = {
			{
				"prettierd",
			},
		},
		javascript = {
			{
				"prettierd",
			},
		},
		css = { "prettierd" },
		html = { "prettierd" },
		sh = { "shfmt" },
		cpp = { "clang-format" },
		java = { "clang-format" },
		python = {
			{
				"autopep8",
			},
		},
		json = {
			"prettierd",
		},
	},
	format = {
		timeout_ms = 3000,
		async = false,
		quiet = false,
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}
