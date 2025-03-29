local plugins = {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = function()
			return require("drxvim.plugins.others.devicons")
		end,
		config = function(_, opts)
			require("nvim-web-devicons").set_default_icon("")
			require("nvim-web-devicons").setup(opts)
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = { { "<C-e>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
		branch = "v3.x",
		dependencies = { "MunifTanjim/nui.nvim" },
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc(-1) == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = function()
			return require("drxvim.plugins.others.neotree")
		end,
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		run = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"HiPhish/rainbow-delimiters.nvim",
			"windwp/nvim-ts-autotag",
			"nushell/tree-sitter-nu",
		},
		opts = function()
			return require("drxvim.plugins.others.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { tab_char = "╎" },
				scope = { enabled = false },
			})
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		event = "BufReadPost",
		opts = function()
			return require("drxvim.plugins.others.indentScope")
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = function()
			return require("drxvim.plugins.others.whichkey")
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup()
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		lazy = true,
		branch = "0.1.x",
		opts = function()
			return require("drxvim.plugins.others.telescope")
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		lazy = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit", "diff" },
		lazy = true,
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" }, {
						on_exit = function(_, return_code)
							if return_code == 0 then
								vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
								vim.schedule(function()
									require("lazy").load({ plugins = { "gitsigns.nvim" } })
								end)
							end
						end,
					})
				end,
				desc = "Load gitsigns only if git repository",
			})
		end,
		opts = function()
			return require("drxvim.plugins.others.gitsigns")
		end,
		config = function(_, opts)
			---@diagnostic disable-next-line
			require("gitsigns").setup(opts)
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		lazy = true,
		config = function(_, opts)
			require("colorizer").setup(opts)
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		lazy = true,
		keys = {
			{
				[[<C-\>]],
				"<cmd>ToggleTerm size=13 direction=horizontal<cr>",
				{ noremap = true, silent = true },
				{ desc = "Toggle Terminal" },
			},
		},
		version = "*",
		config = function()
			require("toggleterm").setup({ shading_factor = 2 })
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" },
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						ft_ignore = { "neo-tree", "Outline" },
						segments = {
							{ sign = { namespace = { "diagnostic*" } } },
							{ sign = { namespace = { "gitsign" } }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, "  " }, click = "v:lua.ScLa" },
							{ text = { builtin.foldfunc, "  " }, click = "v:lua.ScFa" },
						},
					})
				end,
			},
		},
		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	--------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		lazy = true,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("drxvim.plugins.cmp.luasnip").luasnip(opts)
				end,
			},
			{
				"windwp/nvim-autopairs",
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		opts = function()
			return require("drxvim.plugins.cmp.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		dependencies = {
			{
				"nvimdev/lspsaga.nvim",
				config = function()
					require("lspsaga").setup({
						symbol_in_winbar = { show_file = false },
					})
					vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				end,
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
				lazy = true,
				opts = function()
					return require("drxvim.plugins.lsp.mason")
				end,
				config = function(_, opts)
					---@diagnostic disable-next-line
					require("mason").setup(opts)
					vim.api.nvim_create_user_command("MasonInstallAll", function()
						if opts.ensure_installed and #opts.ensure_installed > 0 then
							vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
						end
					end, {})
				end,
			},
			{
				"ray-x/lsp_signature.nvim",
				opts = { hint_enable = false },
				config = function(_, opts)
					require("lsp_signature").setup(opts)
				end,
			},
		},
		config = function()
			require("drxvim.plugins.lsp.lspconfig")
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		lazy = true,
		cmd = "ConformInfo",
		opts = function()
			return require("drxvim.plugins.lsp.conform")
		end,
		config = function(_, opts)
			---@diagnostic disable-next-line
			require("conform").setup(opts)
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		lazy = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("drxvim.ui.lualine.init")
		end,
		config = function(_, opts)
			---@diagnostic disable-next-line
			require("lualine").setup(opts)
		end,
	},
	{
		"lambdalisue/suda.vim",
	},
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- require("supermaven-nvim").setup({})
	-- 	end,
	-- },
	-- {
	-- 	"terminalnode/sway-vim-syntax",
	-- },
	{
		"chomosuke/term-edit.nvim",
		event = "TermOpen",
		version = "1.*",
		config = function()
			require("term-edit").setup({
				prompt_end = "%$ ",
			})
		end,
	},
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		-- require("codeium").setup({})
	-- 	end,
	-- },
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
		end,
		dependencies = {
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			config = function()
				require("copilot").setup({
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end,
		},
	},
}

require("lazy").setup(plugins)
