-- Add treesitter plugin, ASP Syntax Highlighting
return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = "*",
		opts = {
			ensure_installed = {
				"bash",
				"dockerfile",
				"go",
				"html",
				"javascript",
				"json",
				"kotlin",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
		},
	},
}
