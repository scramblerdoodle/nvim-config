return {
	-- Mason config
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			-- vim.list_extend(opts.ensure_installed, { "pyright", "black", "ruff-lsp", "ruff" })
			vim.list_extend(opts.ensure_installed, {
				-- "black",
				-- "ruff",
				-- "debugpy",
				-- "mypy",
				-- "ruff-lsp",
				-- "pyright",
				"rust-analyzer",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			setup = {
				rust_analyzer = function()
					return true
				end,
			},
		},
	},

	-- Setup up format with new `conform.nvim`
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["python"] = { "ruff", "black", "isort" },
				["json"] = { "jq" },
			},
		},
	},
}
