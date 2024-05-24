local configs = {
	formatters_by_ft = {
		lua = { "stylua" },
		php = {
			"pretty-php",
		},
		typescript = {
			{
				"prettierd",
				"prettier",
			},
		},
		typescriptreact = {
			{
				"prettierd",
				"prettier",
			},
		},
		javascriptreact = {
			{
				"prettierd",
				"prettier",
			},
		},
		javascript = {
			{
				"prettierd",
				"prettier",
			},
		},
		css = { "prettier" },
		html = { "prettier" },
		sh = { "shfmt" },
		cpp = { "clangd" },
		python = {
			{
				"autopep8",
			},
		},
		json = {
			"prettierd",
			"prettier",
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

return configs
