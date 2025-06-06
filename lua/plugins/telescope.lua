return {
	"nvim-telescope/telescope.nvim",
	keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
	},
	-- {
	-- 	"nvim-telescope/telescope-ui-select.nvim",
	-- 	opts = {
	-- 		extensions = {
	-- 			["ui-select"] = {
	-- 				require("telescope.themes").get_dropdown({}),
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"nvim-telescope/telescope-project.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("project")
	-- 	end,
	-- },
}
