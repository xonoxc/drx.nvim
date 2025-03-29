-- User defined keybindings

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map(
	"n",
	"j",
	'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
	{ expr = true },
	{ desc = "Move Cursor Down (Allow Wrapped)" }
)
map(
	"n",
	"k",
	'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
	{ expr = true },
	{ desc = "Move Cursor Up (Allow Wrapped)" }
)

map("n", "<C-h>", "<C-w>h", opts, { desc = "Move Cursor Left Buffer" })
map("n", "<C-j>", "<C-w>j", opts, { desc = "Move Cursor Down Buffer" })
map("n", "<C-k>", "<C-w>k", opts, { desc = "Move Cursor Up Buffer" })
map("n", "<C-l>", "<C-w>l", opts, { desc = "Move Cursor Right Buffer" })

map("n", "<M-Up>", ":m-2<CR>", opts, { desc = "Move Line Up" })
map("n", "<M-Down>", ":m+<CR>", opts, { desc = "Move Line Down" })
map("i", "<M-Up>", "<Esc>:m-2<CR>", opts, { desc = "Move Line Up (Insert)" })
map("i", "<M-Down>", "<Esc>:m+<CR>", opts, { desc = "Move Line Down (Insert)" })
map("x", "<M-Up>", ":move '<-2<CR>gv-gv", opts, { desc = "Move Line Up (Visual)" })
map("x", "<M-Down>", ":move '>+1<CR>gv-gv", opts, { desc = "Move Line Down (Visual)" })

map("n", "<C-Up>", ":resize +2<CR>", opts, { desc = "Resize Window Up" })
map("n", "<C-Down>", ":resize -2<CR>", opts, { desc = "Resize Window Down" })
map("n", "<C-Left>", ":vertical resize +2<CR>", opts, { desc = "Resize Window Left" })
map("n", "<C-Right>", ":vertical resize -2<CR>", opts, { desc = "Resize Window Right" })

map("i", "<C-j>", "<Down>", opts, { desc = "Move Cursor Down in Insert Mode" })
map("i", "<C-k>", "<Up>", opts, { desc = "Move Cursor Up in Insert Mode" })
map("i", "<C-h>", "<Left>", opts, { desc = "Move Cursor Left in Insert Mode" })
map("i", "<C-l>", "<Right>", opts, { desc = "Move Cursor Right in Insert Mode" })

map("n", "<TAB>", "<cmd>TeBufNext<CR>", opts, { desc = "Next Buffer" })
map("n", "<S-TAB>", "<cmd>TeBufPrev<CR>", opts, { desc = "Previous Buffer" })

map("n", "<Enter>", "<cmd>nohlsearch<CR>", opts, { desc = "Clear Highlight" })

map("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = true }, { desc = "Rename" })

map("t", "<esc>", [[<C-\><C-n>]], { silent = true }, { desc = "Enter normal mode in termianl buffer" })

-- termianl mappigns
map({ "n", "v" }, "<Leader>t1", "<cmd>1ToggleTerm<CR>", opts, { desc = "Terminal 1" })
map({ "n", "v" }, "<Leader>t2", "<cmd>2ToggleTerm<CR>", opts, { desc = "Terminal 2" })
map({ "n", "v" }, "<Leader>t3", "<cmd>3ToggleTerm<CR>", opts, { desc = "Terminal 3" })
map({ "n", "v" }, "<Leader>t4", "<cmd>4ToggleTerm<CR>", opts, { desc = "Terminal 4" })
map({ "n", "v" }, "<Leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts, { desc = "Float Terminal" })
map(
	{ "n", "v" },
	"<Leader>th",
	"<cmd>ToggleTerm size=10 direction=horizontal<CR>",
	opts,
	{ desc = "Horizontal Terminal" }
)
map({ "n", "v" }, "<Leader>tv", "<cmd>ToggleTerm size=50 direction=vertical<CR>", opts, { desc = "Vertical Terminal" })

-- lazy
map({ "n", "v" }, "<Leader>pC", "<cmd>Lazy clean<CR>", opts, { desc = "Lazy Clean" })
map({ "n", "v" }, "<Leader>pc", "<cmd>Lazy log<CR>", opts, { desc = "Lazy Log" })
map({ "n", "v" }, "<Leader>pi", "<cmd>Lazy install<CR>", opts, { desc = "Lazy Install" })
map({ "n", "v" }, "<Leader>ps", "<cmd>Lazy sync<CR>", opts, { desc = "Lazy Sync" })
map({ "n", "v" }, "<Leader>pS", "<cmd>Lazy show<CR>", opts, { desc = "Lazy Status" })
map({ "n", "v" }, "<Leader>pu", "<cmd>Lazy update<CR>", opts, { desc = "Lazy Update" })

-- Telescope:
map({ "n", "v" }, "<Leader>ff", "<cmd>Telescope find_files<CR>", opts, { desc = "Find File" })
map({ "n", "v" }, "<Leader>fr", "<cmd>Telescope oldfiles<CR>", opts, { desc = "Recent File" })
map({ "n", "v" }, "<Leader>fw", "<cmd>Telescope live_grep<CR>", opts, { desc = "Find Text" })
map({ "n", "v" }, "<Leader>fm", "<cmd>Telescope keymaps<CR>", opts, { desc = "Keymaps" })
map({ "n", "v" }, "<Leader>fM", "<cmd>Telescope man_pages<CR>", opts, { desc = "Man Pages" })
map({ "n", "v" }, "<Leader>fR", "<cmd>Telescope registers<CR>", opts, { desc = "Registers" })
map({ "n", "v" }, "<Leader>fj", "<cmd>Telescope commands<CR>", opts, { desc = "Commands" })
map({ "n", "v" }, "<Leader>fh", "<cmd>Telescope highlights<CR>", opts, { desc = "Highlights" })
map({ "n", "v" }, "<Leader>ft", "<cmd>TodoTelescope<CR>", opts, { desc = "Todo" })

map({ "n", "v" }, "<Leader>fc", "<cmd>lua require('drxvim.themes.switch').setup()<cr>", opts, { desc = "Change Theme" })

-- keymaps for lsp
map({ "n", "v" }, "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts, { desc = "Code Action" })
map(
	{ "n", "v" },
	"<Leader>li",
	"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
	opts,
	{ desc = "Toggle InlayHints" }
)
map({ "n", "v" }, "<Leader>lI", "<cmd>LspInfo<CR>", opts, { desc = "Info" })
map({ "n", "v" }, "<Leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts, { desc = "Next Diagnostic" })
map({ "n", "v" }, "<Leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts, { desc = "Prev Diagnostic" })
map({ "n", "v" }, "<Leader>lo", "<cmd>Lspsaga outline<CR>", opts, { desc = "Outline" })
map({ "n", "v" }, "<Leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts, { desc = "Rename" })
map({ "n", "v" }, "<Leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts, { desc = "Document Symbols" })
map(
	{ "n", "v" },
	"<Leader>lS",
	"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
	opts,
	{ desc = "Workspace Symbols" }
)

map({ "n", "v" }, "<Leader>ld", "<cmd>:Trouble diagnostics toggle<CR>", opts, { desc = "toggle diagnostic" })

-- windows
map({ "n", "v" }, "<Leader>wv", "<C-w>v", opts, { desc = "Vertical Split" })
map({ "n", "v" }, "<Leader>wh", "<C-w>s", opts, { desc = "Horizontal Split" })
map({ "n", "v" }, "<Leader>we", "<C-w>=", opts, { desc = "Make Splits Equal" })
map({ "n", "v" }, "<Leader>wq", "<cmd>close<CR>", opts, { desc = "Close Split" })

-- options

map({ "n", "v" }, "<Leader>oa", "<cmd>lua require('drxvim.user.functions').Ranger()<cr>", opts, { desc = "Ranger" })
map(
	{ "n", "v" },
	"<Leader>ow",
	"<cmd>lua require('drxvim.user.functions').toggle_option('wrap')<cr>",
	opts,
	{ desc = "Wrap" }
)
map(
	{ "n", "v" },
	"<Leader>os",
	"<cmd>lua require('drxvim.user.functions').toggle_option('spell')<cr>",
	opts,
	{ desc = "Spell" }
)
map(
	{ "n", "v" },
	"<Leader>on",
	"<cmd>lua require('drxvim.user.functions').toggle_option('number')<cr>",
	opts,
	{ desc = "Number" }
)
map(
	{ "n", "v" },
	"<Leader>or",
	"<cmd>lua require('drxvim.user.functions').toggle_option('relativenumber')<cr>",
	opts,
	{ desc = "Relative Number" }
)
map(
	{ "n", "v" },
	"<Leader>ot",
	"<cmd>lua require('drxvim.user.functions').toggle_tabline()<cr>",
	opts,
	{ desc = "Tabline" }
)
map(
	{ "n", "v" },
	"<Leader>ol",
	"<cmd>lua require('drxvim.user.functions').toggle_statusline()<cr>",
	opts,
	{ desc = "Statusline" }
)

-- mapping to comment the selection
map({ "n", "v" }, "<Leader>/", "<Plug>(comment_toggle_linewise_current)", opts, { desc = "Comment current line" })

-- mapping to quit the neovim
map({ "n", "v" }, "<Leader>q", "<cmd>qa!<CR>", opts, { desc = "Quit" })
