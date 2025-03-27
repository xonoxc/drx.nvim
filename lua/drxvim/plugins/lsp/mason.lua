local configs = {
	ensure_installed = {
		"typescript-language-server",
		"gopls",
		"vscode-solidity-server",
		"pyright",
		"html-lsp",
		"prisma-language-server",
		"tailwindcss-language-server",
		"lua-language-server",
		"stylua",
		"rust-analyzer",
		"graphql-language-service-cli",
		"css-lsp",
		"clangd",
		"json-lsp",
		"htmx-lsp",
		"phpactor",
		"astro-language-server",
		"docker-compose-language-service",
		"dockerfile-language-server",
		"emmet-language-server",
		"jdtls",
	},
	ui = {
		icons = {
			package_pending = "󰁇 ",
			package_installed = " ",
			package_uninstalled = " ",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			update_all_servers = "U",
			check_server_version = "c",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},
}

return configs
