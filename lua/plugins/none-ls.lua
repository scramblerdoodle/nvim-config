return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.formatting.black,
        -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
      },
    })
  end,
  enabled = false,
}
