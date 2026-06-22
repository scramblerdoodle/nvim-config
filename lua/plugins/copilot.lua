return {
	{
		"github/copilot.vim",
		config = function()
			-- Disable Copilot on startup
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					vim.cmd("Copilot disable")
				end,
			})

			-- Change accept from tab to C-J
			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>cps", "copilot#Suggest()", { desc = "Copilot Suggest" })
			vim.keymap.set("n", "<leader>cpD", "<cmd>Copilot disable<cr><esc>", { desc = "Copilot Disable" })
			vim.keymap.set("n", "<leader>cpE", "<cmd>Copilot enable<cr><esc>", { desc = "Copilot Enable" })
		end,
	},
	-- { "CopilotC-Nvim/CopilotChat.nvim" },
}
