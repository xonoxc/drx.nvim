local snippets = require "mini.snippets"

local M = {}

M.snippets = {
	snippets.gen_loader.from_lang(),
}

return M
