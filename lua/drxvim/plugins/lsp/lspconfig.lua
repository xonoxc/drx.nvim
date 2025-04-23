local M = {}

local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local util = require("lspconfig/util")

M.inlay_hints = false

M.on_attach = function(_, bufnr)
	if M.inlay_hints then
		vim.lsp.inlay_hint.enable(true)
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
	signs = { text = { [1] = " ", [2] = " ", [3] = " ", [4] = "󰛨 " } },
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
	filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
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
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = false,
				functionTypeParameters = false,
				parameterNames = false,
				rangeVariableTypes = false,
			},
		},
	},
})

-- this function ignores all the errors that contain (Debug failure for typescript)--
local function filter_ts_diagnostics(err, result, ctx, config)
	if result and result.diagnostics then
		result.diagnostics = vim.tbl_filter(function(diagnostic)
			return not string.match(diagnostic.message, "Debug Failure")
		end, result.diagnostics)
	end
	vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
end

lspconfig["ts_ls"].setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "typescript-language-server", "--stdio" },
	handlers = {
		["textDocument/publishDiagnostics"] = filter_ts_diagnostics,
	},
	single_file_support = false,
	filetypes = {
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"javascript.jsx",
		"javascript",
		"javascriptreact",
	},
	root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
})

lspconfig.cssls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "vscode-css-language-server", "--stdio" },
	settings = {
		css = {
			lint = { unknownAtRules = "ignore" },
		},
	},
})

lspconfig.html.setup({
	cmd = { "vscode-html-language-server", "--stdio" },
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	filetypes = { "html", "templ", "php", "htmldjango", "html-heex", "heex" },
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
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
			includeLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				htmlangular = "html",
				templ = "html",
			},
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
		},
	},
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
		"templ",
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
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_dir = util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
		"vite.config.ts",
		"postcss.config.js",
		"postcss.config.cjs",
		"postcss.config.mjs",
		"postcss.config.ts",
		"package.json",
		"node_modules",
		".git",
		"requirements.txt"
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
				reportGeneralTypeIssues = false,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
				autoImportCompletions = true,
				diagnosticMode = "workspace",
			},
		},
	},
	single_file_support = true,
})

-- lspconfig.pylsp.setup({
-- 	on_attach = M.on_attach,
-- 	capabilities = M.capabilities,
-- 	cmd = { "pylsp" },
-- 	filetypes = { "python" },
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				jedi = { environment = vim.fn.getcwd() .. "/.venv" },
-- 			},
-- 		},
-- 	},
-- 	root_dir = util.root_pattern("requirements.txt"),
-- 	single_file_support = true,
-- })

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
			completions = {
				commitCharactersSupport = true,
				deprecatedSupport = true,
				documentationFormat = { "markdown", "plaintext" },
				preselectSupport = true,
				snippetSupport = true,
			},
		},
	},
})

lspconfig.templ.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "templ", "lsp" },
	filetypes = { "templ" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
})

lspconfig.jsonls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	fileMatch = { "json", ".eslintrc", ".prettierrc", ".stylelintrc" },
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
		"svelte",
		"htmldjango",
		"heex",
		"javascriptreact",
		"less",
		"pug",
		"templ",
		"sass",
		"scss",
		"php",
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

lspconfig.htmx.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "htmx-lsp" },
	filetypes = {
		"html",
		"templ",
		"heex",
		"htmldjango",
	},
	single_file_support = true,
})

lspconfig.astro.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	init_options = {
		typescript = {},
	},
	root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

lspconfig.phpactor.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "phpactor", "language-server" },
	filetypes = { "php" },
})

lspconfig.jinja_lsp.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "jinja-lsp" },
	filetypes = { "jinja", "htmldjango", "html" },
	name = "jinja_lsp",
	single_file_support = true,
})

lspconfig.zls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_dir = util.root_pattern("zls.json", "build.zig", ".git"),
	single_file_support = true,
})

lspconfig.elixirls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "elixir-ls" },
	filetypes = { "elixir", "eelixir", "heex", "surface" },
})

lspconfig.yamlls.setup({
	on_attach = function(client, bufnr)
		M.on_attach(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
	end,
	capabilities = M.capabilities,
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	settings = {
		yaml = {
			format = {
				enable = true,
			},
			schemaStore = {
				enable = true,
			},
		},
		-- schemas = {
		-- 	["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
		-- 	["http://json.schemastore.org/composer"] = "/*",
		-- },
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
	},
})

-- svelte language server setup ---

lspconfig.svelte.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_dir = util.root_pattern("package.json", ".git"),
})

-- deno language server configuration--
lspconfig.denols.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	init_options = {
		lint = true,
		unstable = true,
	},
	root_dir = util.root_pattern("deno.json", "deno.jsonc"),
})

-- vue language server configuration --

lspconfig.vuels.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "vls" },
	filetypes = { "vue" },
	root_dir = util.root_pattern("package.json", ".git"),
	init_options = {
		config = {
			css = {},
			emmet = {},
			html = {
				suggest = true,
			},
			javascript = {
				format = true,
			},
			stylusSupremacy = {},
			typescript = {
				format = true,
			},
			vetur = {
				completion = {
					autoImport = true,
					tagCasing = "kebab",
					useScaffoldSnippets = true,
				},
				format = {
					defaultFormatter = {
						js = "prettierd",
						ts = "prettierd",
					},
					defaultFormatterOptions = {},
					scriptInitialIndent = true,
					styleInitialIndent = true,
				},
				useWorkspaceDependencies = false,
				validation = {
					script = true,
					style = true,
					template = true,
				},
			},
		},
	},
})

-- odin language server setup for odin langague --
lspconfig.ols.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})

-- solidity language server setup for solidity language --
lspconfig.solidity_ls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})

-- lsp for assembly language --
lspconfig.asm_lsp.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "asm-lsp" },
	filetypes = { "asm", "vasm" },
})

return M
