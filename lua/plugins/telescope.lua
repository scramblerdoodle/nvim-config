return {
  "nvim-telescope/telescope.nvim",
  opts = {
    -- defaults = {
    --   layout_strategy = "horizontal",
    --   layout_config = { prompt_position = "top" },
    --   sorting_strategy = "ascending",
    --   winblend = 0,
    -- },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    opts = {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    },
  },
}
