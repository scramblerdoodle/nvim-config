return {
	-- Mason ensure kotlin LSP, DAP and Lint/Fmt is installed
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				-- "kotlin-language-server",
				"kotlin-lsp",
				"kotlin-debug-adapter",
				"ktlint",
			})
		end,
	},

	-- Neotest setup
	{
		-- TODO: fork this repo and fix the all-tests suite
		-- Problem is: in the `parse_xml_files_from_directory` function,
		-- it starts from the project's root, and tries to save the test results
		-- under `build/test-results/test`. But that doesn't exist since our project uses submodules
		-- and those are the ones actually being built.
		-- Btw, plugin path: ~/.local/share/nvim/lazy/neotest-gradle/
		"bkolof/neotest-gradle",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"codymikol/neotest-kotlin",
		},
		opts = function(_, opts)
			opts.adapters = {
				["neotest-gradle"] = {},
			}
		end,
	},

	-- Debugger Config
	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = "mason-org/mason.nvim",
		opts = function()
			local dap = require("dap")
			if not dap.adapters.kotlin then
				dap.adapters.kotlin = {
					type = "executable",
					command = "kotlin-debug-adapter",
					options = { auto_continue_if_many_stopped = false },
				}
			end

			dap.configurations.kotlin = {
				{
					type = "kotlin",
					request = "launch",
					name = "This file",
					-- may differ, when in doubt, whatever your project structure may be,
					-- it has to correspond to the class file located at `build/classes/`
					-- and of course you have to build before you debug
					mainClass = function()
						local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
						local fname = vim.api.nvim_buf_get_name(0)
						-- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
						return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
					end,
					projectRoot = "${workspaceFolder}",
					jsonLogFile = "",
					enableJsonLogging = false,
				},
				{
					-- Use this for unit tests
					-- First, run
					-- ./gradlew --info cleanTest test --debug-jvm
					-- then attach the debugger to it
					type = "kotlin",
					request = "attach",
					name = "Attach to debugging session",
					port = 5005,
					args = {},
					projectRoot = vim.fn.getcwd,
					hostName = "localhost",
					timeout = 2000,
				},
			}
		end,
	},

	-- TODO: This seems to be deprecated
	-- 		 The DAP is working w the attach to debug sesh option above
	-- { "Mgenuit/nvim-dap-kotlin", config = true },
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = opts.servers or {}

			opts.servers.kotlin_lsp = {
				single_file_support = false,
			}
		end,
	},

	-- Custom Kotlin plugin for configuring everything up together
	-- {
	-- 	"AlexandrosAlexiou/kotlin.nvim",
	-- 	ft = { "kotlin" },
	-- 	dependencies = {
	-- 		"mason.nvim",
	-- 		"mason-lspconfig.nvim",
	-- 		"oil.nvim",
	-- 		"trouble.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("kotlin").setup({
	-- 			-- Default: { "build.gradle", "build.gradle.kts", "pom.xml", "mvnw" }
	-- 			root_markers = {
	-- 				"build.gradle.kts",
	-- 				"gradlew",
	-- 				".git",
	-- 				"mvnw",
	-- 				"settings.gradle",
	-- 			},
	--
	-- 			-- jre_path = nil, -- To use bundled JRE
	--
	-- 			-- If I want to use the specific temurin casket:
	-- 			-- jre_path = "/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home",
	-- 			-- jdk_for_symbol_resolution = "/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home",
	--
	-- 			jvm_args = {
	-- 				"-Xmx4g", -- Increase max heap (useful for large projects)
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
