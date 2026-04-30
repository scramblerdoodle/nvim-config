-- nvim v0.8.0
return {
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		},
	},
}
