local M = {}

local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local util = require("lspconfig/util")

M.on_attach = function(client, bufnr)
	if client.supports_method("textDocument/inlayHint") then
		local value
		local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
		if type(ih) == "function" then
			ih(bufnr, value)
		elseif type(ih) == "table" and ih.enable then
			if value == nil then
				value = not ih.is_enabled(bufnr)
			end
			ih.enable(bufnr, value)
		end
	end
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = { border = "rounded" },
	}, bufnr)
end

M.capabilities =
	vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

M.capabilities.offsetEncoding = { "utf-16", "utf-8" }

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	signs = { text = { [1] = " ", [2] = " ", [3] = " ", [4] = "󰛨 " } },
	float = {
		focusable = false,
		suffix = "",
		header = { "  Diagnostics", "String" },
		prefix = function(_, _, _)
			return "  ", "String"
		end,
	},
})

-- CONFIGS ---
lspconfig.lua_ls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	settings = {
		Lua = {
			hint = { enable = true },
			diagnostics = { globals = { "vim", "awesome", "client", "screen", "mouse", "tag" } },
			workspace = { checkThirdParty = false },
		},
	},
})

lspconfig.gopls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			buildFlags = { "-tags=integration" },
		},
	},
})

lspconfig.tsserver.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript.tsx",
		"typescriptreact",
		"typescript.tsx",
		"typescript",
	},
	root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

lspconfig.cssls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "vscode-css-language-server", "--stdio" },
})

lspconfig.html.setup({
	cmd = { "vscode-html-language-server", "--stdio" },
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
})

lspconfig.clangd.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "clangd", "--background-index" },
	filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp", "inl" },
	root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json"),
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
	},
})

lspconfig.tailwindcss.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir",
		"elixir",
		"ejs",
		"erb",
		"eruby",
		"gohtml",
		"gohtmltmpl",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		-- "javascript",
		"javascriptreact",
		"reason",
		"rescript",
		-- "typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_dir = util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
		"postcss.config.js",
		"postcss.config.cjs",
		"postcss.config.mjs",
		"postcss.config.ts",
		"package.json",
		"node_modules",
		".git"
	),
})

lspconfig.graphql.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "graphql-lsp", "server", "-m", "stream" },
	filetypes = { "graphql", "typescriptreact", "javascriptreact" },
	root_dir = util.root_pattern(".git", ".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
})

lspconfig.pyright.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	settings = {
		pyright = {
			disableLanguageServices = false,
			disableOrgainzeImports = false,
		},
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				diagnosticMode = "workspace",
			},
		},
	},
	single_file_support = true,
})

lspconfig.rust_analyzer.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	filetypes = { "rust" },
	root_dir = util.root_pattern("Cargo.toml"),
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
})

lspconfig.jsonls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
			},
		},
	},
})

lspconfig.docker_compose_language_service.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "docker-compose-language-server", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_dir = util.root_pattern("docker-compose.yaml"),
	single_file_support = true,
})

lspconfig.dockerls.setup({
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_dir = util.root_pattern("Dockerfile"),
	single_file_support = true,
})

lspconfig.emmet_language_server.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "emmet-language-server", "--stdio" },
	filetypes = {
		"css",
		"eruby",
		"html",
		"htmldjango",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"typescriptreact",
	},
	root_dir = util.root_pattern("git root"),
	single_file_support = true,
})

lspconfig.prismals.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "prisma-language-server", "--stdio" },
	filetypes = { "prisma" },
	root_dir = util.root_pattern(".git", "package.json"),
})

lspconfig.jdtls.setup({
	cmd = { "jdtls" },
	filetypes = { "java" },
})

return M
