-- Add Catppuccin theme, with Mocha pallette (darker)
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto",
				transparent_background = true,
				highlight_overrides = {
					mocha = function(colors)
						return {
							SnacksDashboardHeader = {
								fg = colors.lavender,
							},
							SnacksDashboardIcon = {
								fg = colors.pink,
								bold = true,
							},
							SnacksDashboardDesc = {
								fg = colors.pink,
							},
						}
					end,
				},
			})
		end,
	},
	{
		"vague-theme/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({
				transparent = true,
			})
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				transparent = true,
			})
		end,
	},
}
