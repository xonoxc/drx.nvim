local M = {}

M.setup = function()
	local mason_registry = require "mason-registry"

	if mason_registry.has_package "codelldb" then
		local ext = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/"
		local codelldb_path = ext .. "adapter/codelldb"

		require("dap").adapters.codelldb = function(cb, _)
			cb {
				type = "server",
				port = "${port}",
				host = "127.0.0.1",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
					detached = true,
				},
			}
		end

		local cpp_cfg = {
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		}
		require("dap").configurations.cpp = { cpp_cfg }
		require("dap").configurations.c = { cpp_cfg }
		require("dap").configurations.rust = { cpp_cfg }
	end
end

return M
