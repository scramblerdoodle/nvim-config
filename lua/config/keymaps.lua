-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- if I ever want jkl; instead of hjkl
-- noremap ; l
-- noremap l k
-- noremap k j
-- noremap j h

vim.keymap.set("n", "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set(
	"n",
	"<leader>zE",
	"<cmd>set spell spelllang=en_gb<cr><esc>",
	{ desc = "Set Text Language to English (GB)" }
)
vim.keymap.set(
	"n",
	"<leader>zU",
	"<cmd>set spell spelllang=en_us<cr><esc>",
	{ desc = "Set Text Language to English (US)" }
)
vim.keymap.set(
	"n",
	"<leader>zB",
	"<cmd>set spell spelllang=pt_br<cr><esc>",
	{ desc = "Set Text Language to Brazilian" }
)

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})

vim.keymap.set("n", "<leader>cps", "copilot#Suggest()", { desc = "Copilot Suggest" })
vim.keymap.set("n", "<leader>cpD", "<cmd>Copilot disable<cr><esc>", { desc = "Copilot Disable" })
vim.keymap.set("n", "<leader>cpE", "<cmd>Copilot enable<cr><esc>", { desc = "Copilot Enable" })
vim.g.copilot_no_tab_map = true
