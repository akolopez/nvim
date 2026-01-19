return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		branch = "master",
		"nvim-treesitter/nvim-treesitter",
		"github/copilot.vim",
		"nvim-telescope/telescope.nvim",
	},
	config = function(_, opts)
		require("codecompanion").setup(opts)
		require("telescope").load_extension("codecompanion")
	end,
	opts = {
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "WARN", -- or "TRACE"
		},
		inline_suggestions = false,
		strategies = {
			chat = {
				adapter = "copilot",
				model = "gpt-4.0",
				buffer_context = {
					enabled = true,
					max_lines = 1000,
				},
			},
		},
	},
}
