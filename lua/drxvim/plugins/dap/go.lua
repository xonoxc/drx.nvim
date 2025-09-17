local M = {}

M.setup = function()
	local mason_registry = require "mason-registry"

	if mason_registry.has_package "dap-go" then
		require("dap-go").setup()
	end
end

return M
