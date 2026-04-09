-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- if I ever want jkl; instead of hjkl
-- noremap ; l
-- noremap l k
-- noremap k j
-- noremap j h

-- Save file
vim.keymap.set("n", "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Dictionary
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
	{ desc = "Set Text Language to Brazilian (PT)" }
)

-- Open dashboard
vim.keymap.set("n", "<leader>qh", "<cmd>lua Snacks.dashboard()<cr><esc>", { desc = "Open dashboard" })

-- API tests
vim.keymap.set("n", "<leader>thr", "<cmd>Rest run<cr><esc>", { desc = "Test API call" })
vim.keymap.set("n", "<leader>tho", "<cmd>Rest open<cr><esc>", { desc = "Open API result pane" })
vim.keymap.set("n", "<leader>thl", "<cmd>Rest last<cr><esc>", { desc = "Rerun last test" })

-- Marks
vim.keymap.set("n", "<leader>md", function()
	local char = vim.fn.input("Delete mark: ")
	if char ~= "" then
		vim.cmd("delmarks " .. char)
	end
end, { desc = "Delete mark" })
vim.keymap.set("n", "<leader>mm", "<cmd>FzfLua marks<cr>", { desc = "Jump to Mark" })
