local cmp = require "cmp"
local lspkind = require "lspkind"
local MiniSnippets = require "mini.snippets"

local check_backspace = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	---@diagnostic disable-next-line : deprecated
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
end

local configs = {
	snippet = {
		expand = function(args)
			local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
			insert { body = args.body } -- Insert at cursor
			cmp.resubscribe { "TextChangedI", "TextChangedP" }
			require("cmp.config").set_onetime { sources = {} }
		end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-b>"] = cmp.mapping.scroll_docs(-1),
		["<C-f>"] = cmp.mapping.scroll_docs(1),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format {
				symbol_map = {
					Copilot = "",
					Codeium = "",
					Snippet = " ",
					Supermaven = " ",
					Keyword = "󰌋 ",
					Function = "󰆧 ",
					Variable = "󰀫",
				},
				preset = "codicons",
				maxwidth = 40,
			}(entry, vim_item)

			local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
			kind.kind = " " .. string.format(" %s │", strings[1], strings[2]) .. " "
			return kind
		end,
	},
	sources = {
		{ name = "copilot", max_item_count = 2 },
		{ name = "codeium", max_item_count = 2 },
		{ name = "nvim_lsp" },
		{ name = "mini_snippets", max_item_count = 2 },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "supermaven" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	completion = {
		completeopt = "menu,menuone",
	},
	window = {
		documentation = {
			border = "rounded",
			winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
			scrollbar = false,
			col_offset = 0,
		},
		completion = {
			border = "rounded",
			winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSelection,Search:None",
			scrollbar = false,
			col_offset = 0,
			side_padding = 0,
		},
	},
	experimental = {
		ghost_text = true,
		native_menu = false,
	},
}

return configs
