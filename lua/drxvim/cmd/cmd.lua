local cmd = {}

--- Turns a list of chunks into a string
---@param chunks table[]
---@return string
local concat = function(chunks)
	local _c = ""

	for _, chunk in ipairs(chunks) do
		_c = _c .. chunk[2]
	end

	return _c
end

cmd.conf = {
	width = math.floor(0.3 * vim.o.columns),
	cmp_height = 7,

	default = {
		winopts = {
			title = {
				{ "", "CmdBlue" },
				{ "  ", "CmdText" },
				{ "v" .. vim.version().major .. "." .. vim.version().minor .. " ", "CmdText" },
				{ "", "CmdBlue" },
			},
			title_pos = "right",
		},

		icon = { { " 󰣖 ", "CmdBlue" } },
		winhl = "FloatBorder:CmdBlue,Normal:Normal",
		ft = "vim",
	},
	configs = {
		{
			firstc = ":",
			match = "^s/",
			icon = { { "  ", "CmdYellow" } },
		},
		{
			firstc = ":",
			match = "^%d+,%d+s/",
			icon = { { "  ", "CmdOrange" } },
		},
		{
			firstc = ":",
			match = "^=",
			icon = { { "  ", "CmdBlue" } },
			ft = "lua",

			text = function(inp)
				return inp:gsub("^=", "")
			end,
		},
		{
			firstc = ":",
			match = "^lua%s",

			winopts = {
				title = {
					{ "", "CmdViolet" },
					{ "  " .. _VERSION .. " ", "LuaText" },
					{ "", "CmdViolet" },
				},
				title_pos = "right",
			},

			winhl = "FloatBorder:CmdViolet,Normal:Normal",
			icon = { { "  ", "CmdViolet" } },
			ft = "lua",

			text = function(inp)
				local init = inp:gsub("^lua", "")

				if init:match("^(%s+)") then
					return init:gsub("^%s+", "")
				end

				return init
			end,
		},
		{
			firstc = ":",
			match = "^Telescope",
			icon = { { " 󰭎 ", "CmdYellow" } },
		},
		{
			firstc = "?",
			winopts = {
				title = {
					{ "", "CmdOrange" },
					{ " 󰍉 Search ", "SearchUpText" },
					{ "", "CmdOrange" },
				},
				title_pos = "right",
			},
			icon = { { "  ", "CmdOrange" } },
			winhl = "FloatBorder:CmdOrange,Normal:Normal",
		},
		{
			firstc = "/",
			winopts = {
				title = {
					{ "", "CmdYellow" },
					{ " 󰍉 Search ", "SearchDownText" },
					{ "", "CmdYellow" },
				},
				title_pos = "right",
			},
			icon = { { "  ", "CmdYellow" } },
			winhl = "FloatBorder:CmdYellow,Normal:Normal",
		},
		{
			firstc = "=",
			winopts = {
				title = {
					{ "", "CmdGreen" },
					{ "  Calculate ", "CalculateText" },
					{ "", "CmdGreen" },
				},
				title_pos = "right",
			},
			icon = { { " 󰇼 ", "CmdGreen" } },
			winhl = "FloatBorder:CmdGreen,Normal:Normal",
		},
	},

	completion_default = {
		hl = "CmdViolet",
		icon = { { "  ", "CmdViolet" } },
	},
	completion_custom = {
		{
			cmd = "^h",
			hl = "CmdYellow",
			icon = { { " 󰮥 ", "CmdYellow" } },
		},
		{
			cmd = "^Lazy",
			hl = "CmdBlue",
			icon = { { " 💤 " } },
		},
		{
			cmd = "^Telescope",
			hl = "CmdGreen",
			icon = { { " 󰺮 ", "CmdGreen" } },
		},
	},
	paste_support = {
		-- Add paste support with a specific keybinding or handling paste actions
		keybinding = "ctrl-v", -- Default keybinding for pasting (can be changed)
		action = function()
			-- Handle paste action (for example, copy from clipboard and insert it into the cmdline)
			local paste_content = vim.fn.getreg("+") -- Get content from system clipboard
			cmd.state.content = { { "paste", paste_content } } -- Update cmdline with pasted content
			cmd.draw() -- Redraw the cmdline with updated content
		end,
	},
}

-- Cached config for the current iteration
cmd.current_conf = {}
-- Guicursor value
cmd.cursor = nil

-- Custom namespace
cmd.ns = vim.api.nvim_create_namespace("cmd")
-- Scratch buffer for the cmdline
cmd.buf = vim.api.nvim_create_buf(false, true)
-- Window for the cmdline
cmd.win = nil
-- Cmdline state variables(e.g. indent, content, cursor position etc.)
cmd.state = {}

-- Buffer for the completion menu
cmd.comp_buf = vim.api.nvim_create_buf(false, true)
-- Window for the completion menu
cmd.comp_win = nil
-- completion state variable(e.g. selected item, items etc.)
cmd.comp_state = {}

-- Variable to check if the completion window is active
cmd.comp_enable = false
-- Text before the completion menu was opened
cmd.comp_txt = nil

--- Updates the current state of the cmdline
---@param state table
cmd.update_state = function(state)
	cmd.state = vim.tbl_deep_extend("force", cmd.state, state)
	local txt = concat(cmd.state.content)

	for _, conf in ipairs(cmd.conf.configs) do
		if conf.firstc == cmd.state.firstc then
			if conf.match and txt:match(conf.match) then
				cmd.current_conf = conf
				return
			elseif not conf.match then
				cmd.current_conf = conf
				return
			end
		elseif not conf.firstc and conf.match and txt:match(conf.match) then
			cmd.current_conf = conf
			return
		end
	end

	cmd.current_conf = cmd.conf.default
end

--- Updates the completion state
---@param state table
cmd.update_comp_state = function(state)
	cmd.comp_state = vim.tbl_deep_extend("force", cmd.comp_state, state)
end

--- Opens the cmdline
cmd.open = function()
	local w = cmd.conf.width < 1 and math.floor(vim.o.columns * cmd.conf.width) or cmd.conf.width
	local h = 3
	local cmp_h = cmd.conf.cmp_height or 7

	if cmd.win and vim.api.nvim_win_is_valid(cmd.win) then
		vim.api.nvim_win_set_config(
			cmd.win,
			vim.tbl_extend("force", {
				relative = "editor",

				row = cmd.comp_enable == true and math.floor((vim.o.lines - (h + cmp_h)) / 2)
					or math.floor((vim.o.lines - h) / 2),
				col = math.floor((vim.o.columns - w) / 2),

				width = w,
				height = math.max(1, h - 2),
			}, cmd.current_conf.winopts or {})
		)

		if cmd.current_conf.winhl then
			vim.wo[cmd.win].winhighlight = cmd.current_conf.winhl
		end

		if cmd.current_conf.ft then
			vim.bo[cmd.buf].filetype = cmd.current_conf.ft
		end

		if not cmd.comp_win or not vim.api.nvim_win_is_valid(cmd.comp_win) then
			return
		end

		vim.api.nvim_win_set_config(cmd.comp_win, {
			relative = "editor",

			row = math.floor((vim.o.lines - (h + cmp_h)) / 2) + h,
			col = math.floor((vim.o.columns - w) / 2),
		})

		return
	end

	cmd.win = vim.api.nvim_open_win(
		cmd.buf,
		false,
		vim.tbl_extend("force", {
			relative = "editor",

			row = cmd.comp_enable == true and math.floor((vim.o.lines - (h + cmp_h)) / 2)
				or math.floor((vim.o.lines - h) / 2),
			col = math.floor((vim.o.columns - w) / 2),

			width = w,
			height = math.max(1, h - 2),
			zindex = 500,

			border = "rounded",
		}, cmd.current_conf.winopts or {})
	)

	vim.wo[cmd.win].number = false
	vim.wo[cmd.win].relativenumber = false
	vim.wo[cmd.win].statuscolumn = ""

	vim.wo[cmd.win].wrap = false
	vim.wo[cmd.win].list = false

	if cmd.current_conf.winhl then
		vim.wo[cmd.win].winhighlight = cmd.current_conf.winhl
	end

	if cmd.current_conf.ft then
		vim.bo[cmd.buf].filetype = cmd.current_conf.ft
	end
end

cmd.paste = function()
	local paste_content = vim.fn.getreg("+")
	cmd.state.content = { { "paste", paste_content } }
	cmd.draw()
end

vim.api.nvim_set_keymap("i", "<C-v>", [[:lua require'cmd'.paste()<CR>]], { noremap = true, silent = true })

cmd.draw = function()
	local line = concat(cmd.state.content)

	vim.api.nvim_buf_set_lines(cmd.buf, 0, -1, false, { line })

	if cmd.cursor then
		vim.api.nvim_win_set_cursor(cmd.win, { 1, #line + 1 })
	end
end

return cmd
