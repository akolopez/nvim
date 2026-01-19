local home = vim.env.HOME -- Get the home directory

-- LSP Support
return {
	-- LSP Configuration
	-- https://github.com/neovim/nvim-lspconfig
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		-- LSP Management
		-- https://github.com/williamboman/mason.nvim
		{ "williamboman/mason.nvim" },
		-- https://github.com/williamboman/mason-lspconfig.nvim
		{ "williamboman/mason-lspconfig.nvim" },

		-- Auto-Install LSPs, linters, formatters, debuggers
		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

		-- Useful status updates for LSP
		-- https://github.com/j-hui/fidget.nvim
		{ "j-hui/fidget.nvim", opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		-- https://github.com/folke/neodev.nvim
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			-- Install these LSPs automatically
			ensure_installed = {
				"basedpyright",
				"bashls",
				"groovyls",
				"lua_ls",
				"jdtls",
				"jsonls",
				"marksman",
				"sqlls",
			},
		})

		require("mason-tool-installer").setup({
			-- Install these linters, formatters, debuggers automatically
			ensure_installed = {
				"ruff",
				"black",
				"stylua",
				"java-debug-adapter",
				"java-test",
				"google-java-format",
				"pgformatter",
				"prettier",
				"prettierd",
			},
		})

		-- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
		vim.api.nvim_command("MasonToolsInstall")

		-- Call setup on each LSP server
		-- require('mason-lspconfig').setup_handlers({
		--   function(server_name)
		--     -- Don't call setup for JDTLS Java LSP because it will be setup from a separate config
		--     if server_name ~= 'jdtls' then
		--       lspconfig[server_name].setup({
		--         on_attach = lsp_attach,
		--         capabilities = lsp_capabilities,
		--       })
		--     end
		--   end
		-- })

		vim.lsp.enable("basedpyright")
		vim.lsp.enable("sqlls")

		vim.lsp.config("jdtls", {
			settings = {
				java = {
					-- Custom eclipse.jdt.ls options go here
				},
			},
		})

		-- Lua LSP settings
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using (most
						-- likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths
							-- here.
							-- '${3rd}/luv/library'
							-- '${3rd}/busted/library'
						},
						-- Or pull in all of 'runtimepath'.
						-- NOTE: this is a lot slower and will cause issues when working on
						-- your own configuration.
						-- See https://github.com/neovim/nvim-lspconfig/issues/3189
						-- library = {
						--   vim.api.nvim_get_runtime_file('', true),
						-- }
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})

		-- local function listJarFiles(dirs)
		-- 	local root = vim.fs.root(0, ".git")
		-- 	local files = {}
		--
		-- 	local function scan(directory)
		-- 		local handle = vim.loop.fs_scandir(directory)
		-- 		if not handle then
		-- 			return
		-- 		end
		--
		-- 		while true do
		-- 			local name, type = vim.loop.fs_scandir_next(handle)
		-- 			if not name then
		-- 				break
		-- 			end
		--
		-- 			local fullPath = directory .. "/" .. name
		-- 			if type == "directory" then
		-- 				scan(fullPath)
		-- 			elseif name:match("%.jar$") then
		-- 				table.insert(files, fullPath)
		-- 			end
		-- 		end
		-- 	end
		--
		-- 	for _, dir in ipairs(dirs) do
		-- 		scan(root .. dir)
		-- 	end
		-- 	return files
		-- end
		--
		-- -- Groovy LSP settings
		-- vim.lsp.config("groovyls", {
		-- 	-- Unix
		-- 	cmd = {
		-- 		"java",
		-- 		"-jar",
		-- 		home
		-- 			.. "/.local/share/nvim/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar",
		-- 	},
		-- 	settings = {
		-- 		groovy = {
		-- 			classpath = {
		-- 				table.concat(listJarFiles({
		-- 					"/gradle/.gradle/caches/modules-2/files-2.1",
		-- 				})),
		-- 			},
		-- 		},
		-- 	},
		-- })

		-- Globally configure all LSP floating preview popups (like hover, signature help, etc)
		local open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded" -- Set border to rounded
			return open_floating_preview(contents, syntax, opts, ...)
		end
	end,
}
