return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			java = { "google-java-format" },
			python = { "ruff_format", "ruff_organize_imports" },
			-- sql = { "pg_format" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
