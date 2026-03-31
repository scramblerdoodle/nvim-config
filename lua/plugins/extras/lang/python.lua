return {
	-- Add `pyright` to mason
	-- TODO: check following tools -> mypy types-requests types-docutils
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			-- vim.list_extend(opts.ensure_installed, { "pyright", "black", "ruff-lsp", "ruff" })
			vim.list_extend(opts.ensure_installed, {
				"black",
				"ruff",
				"debugpy",
				-- "mypy",
				"pyright",
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
					-- Here you can specify the settings for the adapter, i.e.
					runner = "pytest",
					-- python = ".venv/bin/python",
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
				pyright = {
					settings = { typeCheckingMode = "basic" },
				},
				pylsp = {
					mason = false,
					settings = {
						pylsp = {
							plugins = {
								flake8 = {
									maxLineLength = 120,
								},
								rope_autoimport = {
									enabled = true,
								},
								pycodestyle = {
									maxLineLength = 120,
									enabled = false,
									ignore = { "E501" },
								},
							},
						},
					},
				},

				ruff_lsp = {
					-- handlers = {
					--   ["textDocument/publishDiagnostics"] = function() end,
					-- },
				},
			},
			setup = {
				pylsp = function()
					Snacks.util.lsp.on(function(_, client)
						if client.name == "pylsp" then
							-- disable hover in favor of jedi-language-server
							client.server_capabilities.hoverProvider = false
						end
					end)
				end,
				ruff_lsp = function()
					Snacks.util.lsp.on(function(_, client)
						if client.name == "ruff_lsp" then
							-- Disable hover in favor of Pyright
							client.server_capabilities.hoverProvider = false
						end
					end)
				end,
				pyright = function()
					Snacks.util.lsp.on(function(_, client)
						if client.name == "pyright" then
							-- disable hover in favor of jedi-language-server
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
