local snippets = require "mini.snippets"

local M = {}

M.snippets = {
	snippets.gen_loader.from_lang(),
}

M.mappings = {
	expand = "<C-m>",
	jump_next = "<Tab>",
	jump_prev = "<S-Tab>",
	stop = "<Esc>",
}

M.silent = true

return M
