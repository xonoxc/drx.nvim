local snippets = require "mini.snippets"

local M = {}

M.snippets = {
	snippets.gen_loader.from_lang(),
}

M.mappings = {
	expand = "<C-u>",
	jump_next = "<C-n>",
	jump_prev = "<C-N>",
	stop = "<C-c>",
}

return M
