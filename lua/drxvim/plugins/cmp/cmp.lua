local cmp = require("cmp")
---@diagnostic disable-next-line
local lua_snip = require("luasnip")
local lspkind = require("lspkind")

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	---@diagnostic disable-next-line : deprecated
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local configs = {
	snippet = {
		expand = function(args)
			lua_snip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-c>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif lua_snip.jumpable(1) then
				lua_snip.jump(1)
			elseif lua_snip.expand_or_jumpable() then
				lua_snip.expand_or_jump()
			elseif lua_snip.expandable() then
				lua_snip.expand()
			elseif check_backspace() then
				-- cmp.complete()
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			elseif lua_snip.jumpable(-1) then
				lua_snip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format({
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
			})(entry, vim_item)

			local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
			kind.kind = " " .. string.format(" %s │", strings[1], strings[2]) .. " "
			return kind
		end,
	},
	sources = {
		{ name = "copilot", max_item_count = 2 },
		{ name = "codeium", max_item_count = 2 },
		{ name = "nvim_lsp" },
		{ name = "lua_snip" },
		{ name = "nvim_lua" },
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
