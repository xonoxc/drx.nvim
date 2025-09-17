-- this file contains the configuration for the DAP UI plugin
local M = {}

M.setup = function()
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
end

return M
