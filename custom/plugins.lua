local overrides = require("custom.configs.overrides")
local plugins = {
	{
		"Pocco81/AutoSave.nvim",
		lazy = false,
	},

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				ft = "go",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- overwrite plugin configs

	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-telescope/telescope-dap.nvim",
		opts = function()
			local conf = require("plugins.configs.telescope")
			conf.defaults.mappings.i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<Esc>"] = require("telescope.actions").close,
			}
			conf.extensions_list = { "themes", "terms", "fzf", "dap" }
			return conf
		end,
	},
	-- Install a plugins
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"ray-x/guihua.lua",
		build = "cd lua/fzy && make",
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		-- go install github.com/go-delve/delve/cmd/dlv@latest
		"mfussenegger/nvim-dap",
		init = function()
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"dreamsofcode-io/nvim-dap-go",
		-- "leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
			require("core.utils").load_mappings("dap-go")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = false,
		config = function(_, opts)
			require("nvim-dap-virtual-text").setup()
		end,
	},
	-- {
	-- 	"olexsmir/gopher.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	-- 	ft = "go",
	-- 	config = function(_, opts)
	-- 		require("gopher").setup(opts)
	-- 		require("core.utils").load_mappings("gopher")
	-- 	end,
	-- 	build = function()
	-- 		vim.cmd([[silent! GoInstallDeps]])
	-- 	end,
	-- },
	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/trouble.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			auto_open = true,
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		lazy = false,
		config = function(_, opts)
			require("symbols-outline").setup(opts)
		end,
	},
	{
		"wellle/context.vim",
		lazy = false,
	},
	{
		"folke/which-key.nvim",
		disable = false,
		config = function()
			-- require("plugins.configs.whichkey")
			local present, wk = pcall(require, "which-key")
			if not present then
				return
			end
			wk.register({
				-- add groups
				["<leader>"] = {
					l = { name = "+LSP" },
					b = { name = "+Buffer" },
					d = { name = "+DAP" },
				},
			})
		end,
		setup = function()
			require("core.utils").load_mappings("whichkey")
		end,
	},
}
return plugins
