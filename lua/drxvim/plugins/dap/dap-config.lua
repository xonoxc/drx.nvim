local opts = {
	ensure_installed = { "python", "delve" },
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
		python = function(config)
			config.adaptors = {
				type = "executable",
				command = "/usr/bin/python",
				args = {
					"-m",
					"debugpy.adaptor",
				},
			}
			require("mason-nvim-dap").default_setup(config)
		end,
	},
}

return opts

