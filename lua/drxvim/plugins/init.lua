local plugins = {
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = function()
			return require "drxvim.plugins.others.devicons"
		end,
		config = function(_, opts)
			require("nvim-web-devicons").set_default_icon ""
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
					require "neo-tree"
				end
			end
		end,
		opts = function()
			return require "drxvim.plugins.others.neotree"
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
			return require "drxvim.plugins.others.treesitter"
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = function()
			require("nvim-treesitter.configs").setup {
				enable = false,
			}
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		event = "BufReadPost",
		opts = function()
			return require "drxvim.plugins.others.indentScope"
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = function()
			return require "drxvim.plugins.others.whichkey"
		end,
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
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
			return require "drxvim.plugins.others.telescope"
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
								vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
								vim.schedule(function()
									require("lazy").load { plugins = { "gitsigns.nvim" } }
								end)
							end
						end,
					})
				end,
				desc = "Load gitsigns only if git repository",
			})
		end,
		opts = function()
			return require "drxvim.plugins.others.gitsigns"
		end,
		config = function(_, opts)
			---@diagnostic disable-next-line
			require("gitsigns").setup(opts)
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		opts = {},
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
			require("toggleterm").setup { shading_factor = 2 }
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		config = function()
			require("illuminate").configure {
				filetypes_denylist = { "neo-tree", "Trouble", "DressingSelect", "TelescopePrompt" },
			}
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
					local builtin = require "statuscol.builtin"
					require("statuscol").setup {
						ft_ignore = { "neo-tree", "Outline" },
						segments = {
							{ sign = { namespace = { "diagnostic*" } } },
							{ sign = { namespace = { "gitsign" } }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, "  " }, click = "v:lua.ScLa" },
							{ text = { builtin.foldfunc, "  " }, click = "v:lua.ScFa" },
						},
					}
				end,
			},
		},
		config = function()
			require("ufo").setup {
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			}
		end,
	},

	--------------------------------------------------------------
	{
		"echasnovski/mini.snippets",
		dependencies = "rafamadriz/friendly-snippets",
		event = "InsertEnter",
		opts = function()
			return require "drxvim.plugins.cmp.snippets"
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"abeldekat/cmp-mini-snippets",
			"onsails/lspkind.nvim",
			{
				"windwp/nvim-autopairs",
				event = "InsertEnter",
				opts = function()
					require("nvim-autopairs").setup { fast_wrap = {}, disable_filetype = { "TelescopePrompt", "vim" } }
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		opts = function()
			return require "drxvim.plugins.cmp.cmp"
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
					require("lspsaga").setup {
						symbol_in_winbar = { show_file = false },
					}
					vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				end,
			},
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
				lazy = true,
				opts = function()
					return require "drxvim.plugins.lsp.mason"
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
			--[[ {
				"ray-x/lsp_signature.nvim",
				opts = { hint_enable = false },
				config = function(_, opts)
					require("lsp_signature").setup(opts)
				end,
			}, ]]
		},
		config = function()
			require "drxvim.plugins.lsp.lspconfig"
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		lazy = true,
		cmd = "ConformInfo",
		opts = function()
			return require "drxvim.plugins.lsp.conform"
		end,
		config = function(_, opts)
			---@diagnostic disable-next-line
			require("conform").setup(opts)
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {
			icons = {
				folder_closed = " ",
				folder_open = " ",
				last = "╰╴", -- rounded
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>ld",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>lD",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"lambdalisue/suda.vim",
	},
	{
		"chomosuke/term-edit.nvim",
		event = "TermOpen",
		version = "1.*",
		config = function()
			require("term-edit").setup {
				prompt_end = "%$ ",
			}
		end,
	},
	--  {
	-- "Exafunction/codeium.nvim",
	-- dependencies = {
	-- 	"nvim-lua/plenary.nvim",
	-- 	"hrsh7th/nvim-cmp",
	-- },
	-- config = function()
	-- 	require("codeium").setup({})
	-- end,
	--},
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
				require("copilot").setup {
					suggestion = { enabled = false },
					panel = { enabled = false },
					logger = {
						enabled = false,
					},
				}
			end,
		},
	},

	-- this is for debugger integration in neovim
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- required by dap-ui
			"jay-babu/mason-nvim-dap.nvim", -- installs adapters
			"williamboman/mason.nvim",
			"theHamsta/nvim-dap-virtual-text", -- inline vars
			-- Language helpers (optional but comfy)
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
			"mxsdev/nvim-dap-vscode-js", -- JS/TS adapter bridge
		},
		config = function()
			-- Mason
			require("mason").setup()
			require("mason-nvim-dap").setup {
				automatic_installation = true,
				ensure_installed = {
					"debugpy", -- Python
					"delve", -- Go
					"codelldb", -- Rust/C/C++
					"js-debug-adapter", -- JS/TS
					-- add "bash" if you want the bash adapter too
				},
				handlers = {}, -- keep defaults
			}

			-- Virtual text (inline values)
			require("nvim-dap-virtual-text").setup {}

			-- UI
			local dap, dapui = require "dap", require "dapui"
			dapui.setup {
				controls = { enabled = true },
				floating = { border = "rounded" },
				layouts = {
					{ elements = { "scopes", "breakpoints", "stacks", "watches" }, size = 40, position = "left" },
					{ elements = { "repl", "console" }, size = 10, position = "bottom" },
				},
			}
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Pretty signs
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			-- Keymaps (change to taste)
			local map = vim.keymap.set
			map("n", "<F5>", function()
				dap.continue()
			end, { desc = "DAP Continue" })
			map("n", "<F10>", function()
				dap.step_over()
			end, { desc = "DAP Step Over" })
			map("n", "<F11>", function()
				dap.step_into()
			end, { desc = "DAP Step Into" })
			map("n", "<F12>", function()
				dap.step_out()
			end, { desc = "DAP Step Out" })
			map("n", "<leader>b", function()
				dap.toggle_breakpoint()
			end, { desc = "DAP Toggle Breakpoint" })
			map("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
			end, { desc = "DAP Conditional Breakpoint" })
			map("n", "<leader>dr", function()
				dap.repl.toggle()
			end, { desc = "DAP REPL" })
			map("n", "<leader>du", function()
				dapui.toggle { reset = true }
			end, { desc = "DAP UI Toggle" })

			-- ---------- Language adapters ----------
			-- PYTHON (debugpy)
			local mason_registry = require "mason-registry"
			if mason_registry.has_package "debugpy" then
				local dbg_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
				require("dap-python").setup(dbg_path)
				-- extra launch config (optional)
				require("dap").configurations.python = {
					{
						type = "python",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						console = "integratedTerminal",
					},
				}
			end

			-- GO (delve)
			if mason_registry.has_package "delve" then
				require("dap-go").setup()
			end

			-- RUST/C/C++ (codelldb)
			if mason_registry.has_package "codelldb" then
				local ext = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/"
				local codelldb_path = ext .. "adapter/codelldb"

				require("dap").adapters.codelldb = function(cb, _)
					cb {
						type = "server",
						port = "${port}",
						host = "127.0.0.1",
						executable = {
							command = codelldb_path,
							args = { "--port", "${port}" },
							detached = true,
						},
					}
				end

				local cpp_cfg = {
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				}
				require("dap").configurations.cpp = { cpp_cfg }
				require("dap").configurations.c = { cpp_cfg }
				require("dap").configurations.rust = { cpp_cfg }
			end

			-- JAVASCRIPT / TYPESCRIPT (js-debug)
			if mason_registry.has_package "js-debug-adapter" then
				local jsdbg = mason_registry.get_package "js-debug-adapter"
				local dbg_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug-adapter"
				require("dap-vscode-js").setup {
					debugger_path = dbg_path,
					adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
				}

				local langs = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
				for _, l in ipairs(langs) do
					require("dap").configurations[l] = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch current file",
							program = "${file}",
							cwd = "${workspaceFolder}",
							sourceMaps = true,
							resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
							outFiles = { "${workspaceFolder}/**/*.js" },
							skipFiles = { "<node_internals>/**" },
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach to process",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
							sourceMaps = true,
						},
					}
				end
			end
		end,
	},
}

require("lazy").setup(plugins)
