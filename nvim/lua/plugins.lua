local M = {}

local fn = vim.fn
local cmd = vim.cmd

local packer_bootstrap = false

local function packer_init()
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		packer_bootstrap = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		cmd([[packadd packer.nvim]])
	end
	cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
end

packer_init()

function M.setup()
	local conf = {
		compile_path = fn.stdpath("config") .. "/lua/packer_compiled.lua",
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	local function plugins(use)
		-- plugin imaptient requires to restart nvim twice
		use({ "lewis6991/impatient.nvim" }) -- speed up loading Lua modules
		use({ "wbthomason/packer.nvim" }) -- plugin manager

		-- Color scheme
		use({
			"kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({ default = true })
			end,
		})
		use({
			"NLKNguyen/papercolor-theme",
			config = function()
				-- vim.cmd("colorscheme PaperColor")
			end,
		})
		use({
			"ray-x/aurora",
			config = function()
				vim.cmd("colorscheme aurora")
			end,
		})
		use({
			"sainnhe/gruvbox-material",
			config = function()
				-- vim.cmd("colorscheme gruvbox-material")
			end,
		})
		use({
			"folke/tokyonight.nvim",
			config = function()
				-- vim.cmd("colorscheme tokyonight")
			end,
		})
		use({
			"EdenEast/nightfox.nvim",
			config = function()
				-- vim.cmd("colorscheme nightfox")
			end,
		})

		-- Development
		use({ "tpope/vim-fugitive" })
		use({
			"kdheepak/lazygit.nvim",
			config = function()
				require("config.lazygit").setup()
			end,
		})
		use({ "tpope/vim-surround" })
		use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })
		-- use { "numToStr/Comment.nvim",
		-- 	keys = { "gc", "gcc", "gbc" },
		-- 	config = function()
		-- 		require("config.comment").setup()
		-- 	end,
		-- }
		use({ "tpope/vim-commentary" })
		use({ "tpope/vim-rhubarb" })
		use({ "tpope/vim-unimpaired" })
		-- use({ "tpope/vim-vinegar" })
		use({ "tpope/vim-sleuth" })
		use({ "wellle/targets.vim" })
		use({ "easymotion/vim-easymotion" })
		use({
			"lewis6991/gitsigns.nvim",
			-- event = "BufReadPre",
			-- wants = "plenary.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("gitsigns").setup()
			end,
		})
		use({ "Pocco81/AutoSave.nvim" })
		--  use { "TimUntersberger/neogit",
		--    cmd = "Neogit",
		--    config = function()
		--      require("config.neogit").setup()
		--    end,
		--  }
		use({
			"folke/which-key.nvim",
			-- branch = "patch-1",
			config = function()
				-- require("which-key").setup{}
				require("config.whichkey").setup()
			end,
		})
		-- Project settings
		use({
			"ahmedkhalf/project.nvim",
			event = "VimEnter",
			config = function()
				require("config.project").setup()
			end,
		})
		-- works for system having a graphical browser
		-- use({
		-- 	"iamcco/markdown-preview.nvim",
		-- 	run = "cd app && yarn install",
		-- 	ft = "markdown",
		-- 	cmd = { "MarkdownPreview" },
		-- })
		-- use { "rmagatti/session-lens",
		--   requires = { "rmagatti/auto-session" },
		--   config = function()
		--     require("config.auto-session").setup()
		--     require("session-lens").setup {}
		--   end,
		-- }

		-- Workflows
		use({ "voldikss/vim-browser-search", event = "VimEnter" })
		use({ "tyru/open-browser.vim", event = "VimEnter" })
		use({
			"michaelb/sniprun",
			cmd = { "SnipRun" },
			run = "bash install.sh",
			config = function()
				require("config.sniprun").setup()
			end,
		})

		-- Testing
		use({
			"rcarriga/vim-ultest",
			config = "require('config.test').setup()",
			run = ":UpdateRemotePlugins",
			requires = { "vim-test/vim-test" },
		})
		use({ "stevearc/stickybuf.nvim" })

		-- Better syntax
		use({
			"nvim-treesitter/nvim-treesitter",
			as = "nvim-treesitter",
			event = "BufRead",
			opt = true,
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
				{ "JoosepAlviste/nvim-ts-context-commentstring" },
				{ "p00f/nvim-ts-rainbow" },
				{ "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
				{ "nvim-treesitter/nvim-treesitter-textobjects" },
				{ "RRethy/nvim-treesitter-textsubjects" },
				-- { "windwp/nvim-autopairs",
				--   run = "make",
				--   config = function()
				--     require("nvim-autopairs").setup {}
				--   end,
				-- },
				{
					"windwp/nvim-ts-autotag",
					config = function()
						require("nvim-ts-autotag").setup({ enable = true })
					end,
				},
				{
					"romgrk/nvim-treesitter-context",
					config = function()
						require("treesitter-context.config").setup({ enable = true })
					end,
				},
				{
					"mfussenegger/nvim-ts-hint-textobject",
					config = function()
						vim.cmd([[omap     <silent> m :<C-U>lua require("tsht").nodes()<CR>]])
						vim.cmd([[vnoremap <silent> m :lua require("tsht").nodes()<CR>]])
					end,
				},
			},
		})
		use({
			"stevearc/aerial.nvim",
			config = function()
				require("config.aerial").setup()
			end,
		})

		-- Dashboard
		-- use {
		--   "glepnir/dashboard-nvim",
		--   config = function()
		--     require("config.dashboard").setup()
		--   end,
		-- }
		-- use { "mhinz/vim-startify" }
		-- use {
		--   "startup-nvim/startup.nvim",
		--   config = function()
		--     require("startup").setup { theme = "evil" }
		--   end,
		-- }
		-- use {
		--   "echasnovski/mini.nvim",
		--   config = function()
		--     local starter = require "mini.starter"
		--     starter.setup {
		--       items = {
		--         starter.sections.telescope(),
		--       },
		--       content_hooks = {
		--         starter.gen_hook.adding_bullet(),
		--         starter.gen_hook.aligning("center", "center"),
		--       },
		--     }
		--   end,
		-- }
		-- use {
		--   "goolord/alpha-nvim",
		--   config = function()
		--     require("config.alpha").setup()
		--   end,
		-- }

		use({
			"nvim-lualine/lualine.nvim",
			after = "nvim-treesitter",
			config = function()
				require("config.lualine").setup()
			end,
		})

		use({
			"akinsho/nvim-bufferline.lua",
			config = function()
				require("config.bufferline").setup()
			end,
			event = "BufReadPre",
		})

		-- Filesystem
		if false then
			use({
				"preservim/nerdtree",
				config = function()
					require("config.nerdtree").setup()
				end,
			})
			use({ "Xuyuanp/nerdtree-git-plugin" })
		else
			use({
				"kyazdani42/nvim-tree.lua",
				requires = "kyazdani42/nvim-web-devicons",
				config = function()
					require("config.nvim-tree").setup()
				end,
			})
		end
		use({
			"AckslD/nvim-neoclip.lua",
			config = function()
				require("neoclip").setup()
			end,
		})
		use({
			"windwp/nvim-spectre",
			event = "VimEnter",
			config = function()
				require("spectre").setup()
			end,
		})
		use({ "djoshea/vim-autoread" })

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			module = "telescope",
			as = "telescope",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-lua/popup.nvim",
				"BurntSushi/ripgrep",
				"nvim-telescope/telescope-project.nvim",
				"nvim-telescope/telescope-symbols.nvim",
				"nvim-telescope/telescope-media-files.nvim",
				"nvim-telescope/telescope-github.nvim",
				"fhill2/telescope-ultisnips.nvim",
				"cljoly/telescope-repo.nvim",
				"kdheepak/lazygit.nvim",
				"jvgrootveld/telescope-zoxide",
				"dhruvmanila/telescope-bookmarks.nvim",
				-- 'nvim-telescope/telescope-hop.nvim'
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				--     {
				--       "nvim-telescope/telescope-arecibo.nvim",
				--       rocks = { "openssl", "lua-http-parser" },
				--     },
				-- {
				--   "nvim-telescope/telescope-frecency.nvim",
				--   requires = { "tami5/sql.nvim" },
				-- },
				{
					"nvim-telescope/telescope-vimspector.nvim",
					event = "BufWinEnter",
				},
				{ "nvim-telescope/telescope-dap.nvim" },
			},
			config = function()
				require("config.telescope").setup()
			end,
		})

		-- Completion
		use({ "hrsh7th/cmp-buffer", after = "cmp" })
		use({
			"hrsh7th/nvim-cmp",
			as = "cmp",
			after = "nvim-treesitter",
			opt = true,
			requires = {
				"quangnguyen30192/cmp-nvim-ultisnips",
				"hrsh7th/cmp-nvim-lua",
				"octaltree/cmp-look",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-calc",
				"f3fora/cmp-spell",
				"hrsh7th/cmp-emoji",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
			},
			config = function()
				require("config.cmp").setup()
			end,
		})
		use({
			"tami5/lspsaga.nvim",
			config = function()
				require("config.lspsaga").setup()
			end,
		})
		use({
			"onsails/lspkind-nvim",
			config = function()
				require("lspkind").init()
			end,
		})
		use({ "kshenoy/vim-signature", event = "BufWinEnter" })
		use({ "ray-x/lsp_signature.nvim" })
		use({
			"folke/trouble.nvim",
			event = "VimEnter",
			cmd = { "TroubleToggle", "Trouble" },
			config = function()
				require("trouble").setup({ auto_open = false })
			end,
		})
		-- For vsnip users.
		-- use { "hrsh7th/cmp-vsnip" }
		-- use { "hrsh7th/vim-vsnip" }

		-- For luasnip users.
		-- use { "L3MON4D3/LuaSnip" }
		-- use { "saadparwaiz1/cmp_luasnip" }

		-- For snippy users.
		-- use { "dcampos/nvim-snippy" }
		--use { "dcampos/cmp-snippy" }

		-- Snippets
		use({
			"SirVer/ultisnips",
			requires = {
				{ "honza/vim-snippets", rtp = "." },
				"mlaursen/vim-react-snippets",
			},
			config = function()
				vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
				vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
				vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
				vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
				vim.g.UltiSnipsRemoveSelectModeMappings = 0
				--     vim.opt.completeopt = "menuone,noinsert,noselect"
				--     vim.g.completion_confirm_key = ""
				--     vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}
				--     vim.g.diagnostic_enable_virtual_text = 1
				--     vim.g.completion_enable_snippet = "UltiSnips"
				--     vim.g.completion_enable_auto_popup = 1
				--     vim.g.completion_enable_auto_hover = 1
				--     vim.g.completion_enable_auto_signature = 0
				--     vim.g.completion_matching_smart_case = 1
			end,
		})
		-- Lua development
		-- use { "tjdevries/nlua.nvim" }
		-- use { "folke/lua-dev.nvim", event = "VimEnter" }
		-- use { "simrat39/symbols-outline.nvim",
		--   event = "VimEnter",
		--   config = function()
		--     require("config.symbols-outline").setup()
		--   end,
		-- }

		-- LSP and completion
		use({ "williamboman/nvim-lsp-installer" })
		use({ "jose-elias-alvarez/null-ls.nvim" })
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({
			"neovim/nvim-lspconfig",
			as = "nvim-lspconfig",
			after = { "nvim-treesitter", "nvim-lsp-installer", "cmp" },
			opt = true,
			requires = {
				"ray-x/lsp_signature.nvim",
			},
			config = function()
				require("config.lsp").setup()
				require("config.dap").setup()
			end,
		})

		-- Lua development
		use({ "tjdevries/nlua.nvim" })
		use({ "folke/lua-dev.nvim", event = "VimEnter" })
		-- use { "simrat39/symbols-outline.nvim",
		--   event = "VimEnter",
		--   config = function()
		--     require("config.symbols-outline").setup()
		--   end,
		-- }

		-- debugging/DAP
		use({ "puremourning/vimspector", event = "BufWinEnter" })
		-- DAP
		use({ "mfussenegger/nvim-dap", event = "BufWinEnter", as = "nvim-dap" })
		use({ "mfussenegger/nvim-dap-python", after = "nvim-dap" })
		use({
			"theHamsta/nvim-dap-virtual-text",
			after = "nvim-dap",
			config = function()
				require("nvim-dap-virtual-text").setup({})
			end,
		})
		use({ "rcarriga/nvim-dap-ui", after = "nvim-dap" })
		use({ "Pocco81/DAPInstall.nvim", after = "nvim-dap" })
		use({ "jbyuki/one-small-step-for-vimkind", after = "nvim-dap" })
		-- use({
		-- 	"leoluz/nvim-dap-go",
		-- 	config = function()
		-- 		require("dap-go").setup()
		-- 	end,
		-- })
		use({
			"yriveiro/dap-go.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			after = { "nvim-lspconfig" },
			config = function()
				require("dap-go").setup({
					external_config = {
						enable = true,
						path = require("lspconfig.util").find_git_ancestor(vim.loop.fs_realpath("."))
							.. "/.vscode/dap-go.json",
					},
				})
			end,
		})

		if packer_bootstrap then
			print("Setting up Neovim. Restart required after installation!")
			require("packer").sync()
		end
	end

	pcall(require, "impatient")
	pcall(require, "packer_compiled")
	require("packer").init(conf)
	require("packer").startup(plugins)
	-- return require("packer").startup(plugins,conf)
end

return M
