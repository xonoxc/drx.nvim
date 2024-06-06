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
		typescriptreact = {
			{
				"prettierd",
			},
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
		cpp = { "clangd" },
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
