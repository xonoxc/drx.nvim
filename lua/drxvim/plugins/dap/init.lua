local M = {}

M.setup = function()
	require("drxvim.plugins.dap.ui").setup()
	require("drxvim.plugins.dap.python").setup()
	require("drxvim.plugins.dap.go").setup()
	require("drxvim.plugins.dap.rust").setup()
	require("drxvim.plugins.dap.js").setup()
end

return M
