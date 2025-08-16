local snippets = require "mini.snippets"

local M = {}

M.snippets = {
	snippets.gen_loader.from_file "~/.config/nvim/snippets/global.json",
	snippets.gen_loader.from_lang(),
}

return M
