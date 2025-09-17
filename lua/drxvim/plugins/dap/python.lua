local M = {}

M.setup = function()
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
end

return M
