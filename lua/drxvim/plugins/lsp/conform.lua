return {
	formatters_by_ft = {
		lua = { "stylua" },
		php = { "pretty-php" },
		typescript = { "prettierd" },
		svelte = { "prettierd" },
		typescriptreact = { "prettierd" },
		javascriptreact = { "prettierd" },
		javascript = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		sh = { "shfmt" },
		cpp = { "clang-format" },
		java = { "clang-format" },
		asm = { "asmfmt" },
		go = {
			"gofumpt",
		},
		python = function(bufnr)
			if require("conform").get_formatter_info("ruff_format", bufnr).available then
				return { "ruff_format" }
			else
				return { "isort", "black" }
			end
		end,
		json = {
			"prettierd",
			"prettier",
			stop_after_first = true,
		},
	},

	formatters = {
		prettierd = {
			args = function(_, ctx)
				return { "--stdin-filepath", ctx.filename }
			end,
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
