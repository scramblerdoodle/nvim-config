return {
	-- Mason config
	{
		"mason-org/mason.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			setup = {
				-- rust_analyzer = function()
				-- 	return true
				-- end,
			},
		},
	},

	-- Setup up format with new `conform.nvim`
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["python"] = { "ruff_organize_imports", "ruff_format" },
				["json"] = { "jq" },
				["kotlin"] = { "ktlint" },
			},
		},
	},
}
