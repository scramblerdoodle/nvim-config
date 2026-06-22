return {
	-- TODO: check following tools -> mypy types-requests types-docutils
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"basedpyright",
				"ruff",
				"debugpy",
				-- "mypy",
			})
		end,
	},

	-- Setup `neotest`
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-python",
		},
		opts = {
			adapters = {
				["neotest-python"] = {
					runner = "pytest",
				},
			},
		},
	},

	-- Add `server` and setup lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		opts = {
			servers = {
				-- pylsp = {
				-- 	settings = {
				-- 		pylsp = {
				-- 			plugins = {
				-- 				flake8 = {
				-- 					maxLineLength = 120,
				-- 				},
				-- 				rope_autoimport = {
				-- 					enabled = true,
				-- 				},
				-- 				pycodestyle = {
				-- 					maxLineLength = 120,
				-- 					enabled = false,
				-- 					ignore = { "E501" },
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },

				ruff = {
					-- handlers = {
					--   ["textDocument/publishDiagnostics"] = function() end,
					-- },
				},

				basedpyright = {
					settings = {
						basedpyright = {
							disableOrganizeImports = true,
							analysis = {
								diagnosticMode = "openFilesOnly",
								typeCheckingMode = "standard",
								autoImportCompletions = false,
							},
						},
					},
				},
			},
			setup = {
				basedpyright = function()
					Snacks.util.lsp.on(function(_, client)
						if client.name == "basedpyright" then
							client.server_capabilities.hoverProvider = true
						end
					end)
				end,
				ruff = function()
					Snacks.util.lsp.on(function(_, client)
						if client.name == "ruff" then
							client.server_capabilities.hoverProvider = false
						end
					end)
				end,
			},
		},
	},

	-- Setup null-ls with `black`
	-- {
	--   "nvimtools/none-ls.nvim",
	--   opts = function(_, opts)
	--     local nls = require("null-ls")
	--     opts.sources = vim.list_extend(opts.sources, {
	--       -- Order of formatters matters. They are used in order of appearance.
	--       nls.builtins.formatting.ruff,
	--       nls.builtins.formatting.black,
	--       -- nls.builtins.formatting.black.with({
	--       --   extra_args = { "--preview" },
	--       -- }),
	--       -- nls.builtins.diagnostics.ruff,
	--     })
	--   end,
	-- },

	-- For selecting virtual envs
	-- TODO: ft = "python" not really doing anything, this shows up for other file types too
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			{ "nvim-telescope/telescope.nvim", version = "*" },
		},
		ft = "python", -- Only load when opening Python files
		opts = {
			dap_enabled = true,
		},
		keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
	},
}
