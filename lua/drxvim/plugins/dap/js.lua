local M = {}

M.setup = function()
	local mason_registry = require "mason-registry"

	if mason_registry.has_package "js-debug-adapter" then
		local dbg_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug-adapter"
		require("dap-vscode-js").setup {
			debugger_path = dbg_path,
			adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
		}

		local langs = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
		for _, l in ipairs(langs) do
			require("dap").configurations[l] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch current file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
					outFiles = { "${workspaceFolder}/**/*.js" },
					skipFiles = { "<node_internals>/**" },
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
				},
			}
		end
	end
end

return M
