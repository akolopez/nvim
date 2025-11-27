vim.keymap.set("n", "<Esc>", ":noh<Esc>")

local wk = require("which-key")
local telescope = require("telescope.builtin")
wk.add({
	{
		mode = { "i" },
		-- navigation
		{ "jj", "<Esc>", hidden = true },
		{ "kk", "<Esc>", hidden = true },

		{ "<C-Space>", "<cmd>lua vim.lsp.buf.completion()<CR>" },
	},
	{
		mode = { "n" },
		-- telescope
		{ "<leader>f", group = "find" },
		{ "<leader>ff", telescope.find_files, desc = "[f]ind files" },
		{ "<leader>fc", telescope.grep_string, desc = "find under [c]ursor" },
		{ "<leader>fg", telescope.live_grep, desc = "[g]rep in project" },
		{ "<leader>fb", telescope.buffers, desc = "[b]uffers" },
		{ "<leader>fh", telescope.help_tags, desc = "[h]elp tags" },

		-- LSP
		{ "<leader>g", group = "go_to" },
		{ "<leader>gg", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "hover" },
		{ "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "[d]efinition" },
		{ "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "[D]eclaration" },
		{ "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "[i]mplementation" },
		{ "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "[t]ype definition" },
		{ "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "[r]eferences" },
		{ "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "[s]ignature help" },
		{ "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "[r]ename" },
		{ "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", desc = "[f]ormat" },
		{ "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code [a]ctions" },
		{ "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Open F[l]oat" },
		{ "<leader>gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "[p]revious" },
		{ "<leader>gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "[n]ext" },
		{ "<leader>gO", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", desc = "d[O]cument symbol" },

		-- quickfix
		{ "<leader>q", group = "quickfix" },
		{ "<leader>qo", ":copen<CR>", desc = "open" },
		{ "<leader>qc", ":cclose<CR>", desc = "close" },
		{ "<leader>qn", ":cnext<CR>", desc = "next" },
		{ "<leader>qp", ":cprev<CR>", desc = "previous" },
	},
	{
		mode = { "v" },
		{ "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>" },
	},
})
