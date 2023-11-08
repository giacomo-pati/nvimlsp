local M = {
	disabled = {
		n = {
			["<leader>b"] = "",
		},
	},
	general = {
		n = {
			["<C-a>"] = {
				"<cmd>NvimTreeToggle<cr>",
				"Toggle NvimTree",
			},
			["<leader>gg"] = {
				"<cmd>LazyGit<cr>",
				"lazygit",
			},
			["<leader>ss"] = {
				"<cmd>lua require('spectre').open()<cr>",
				"Search file",
			},
			["<leader>ba"] = {
				"<cmd>%bd|e#|bd#<Cr>",
				"Delete all buffers",
			},
			["<leader>bd"] = {
				"<cmd>bd<cr>",
				"Buffer delete",
			},
		},
		v = {
			["<leader>sv"] = {
				"<Cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				"Visual search",
			},
		},
	},
	lspconfig = {
		plugin = true,
		n = {
			["<leader>lr"] = {
				function()
					require("nvchad.renamer").open()
				end,
				"Rename symbol",
			},
			["<leader>lu"] = {
				"<Cmd>Telescope lsp_references<CR>",
				"References",
			},
			["<leader>li"] = {
				"<Cmd>Telescope lsp_implementations<CR>",
				"Implementations",
			},
			["<leader>lo"] = {
				"<Cmd>Telescope lsp_document_symbols<CR>",
				"Document symbols",
			},
			["<leader>lc"] = {
				"<Cmd>lua vim.lsp.buf.declaration<CR>",
				"Declaration",
			},
			["<leader>ld"] = {
				"<Cmd>Telescope lsp_definitions<CR>",
				"Definition",
			},
			["<leader>la"] = {
				"<Cmd>Telescope lsp_code_actions<CR>",
				"Code actions",
			},
			["<leader>le"] = {
				"<Cmd>lua vim.diagnostic.enable()<CR>",
				"Enable diagnostics",
			},
			["<leader>lf"] = {
				function()
					vim.lsp.buf.format({ async = true })
				end,
				"Format",
			},
			["<leader>lx"] = {
				"<Cmd>lua vim.diagnostic.disable()<CR>",
				"Disable diagnostics",
			},
			["<leader>lt"] = {
				"<Cmd>lua require('trouble').toggle()<CR>",
				"Trouble",
			},
			["<leader>ll"] = {
				"<Cmd>SymbolsOutline<CR>",
				"Outlines",
			},
		},
	},
	dap = {
		plugin = true,
		n = {
			["<leader>db"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
			["<leader>dl"] = {
				function()
					local widgets = require("dap.ui.widgets")
					local sidebar = widgets.sidebar(widgets.scopes)
					sidebar.open()
				end,
				"Open debugging sidebar",
			},
			["<leader>dc"] = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
			["<leader>dt"] = { "<cmd>lua require('dap-go').debug_test()<cr>", "Continue Test" },
			["<leader>ds"] = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
			["<leader>di"] = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
			["<leader>do"] = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
			["<leader>du"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" },
			["<leader>dp"] = { "<cmd>lua require('dap').repl.open()<cr>", "Step out" },
			-- ["<leader>dl"] = { "cmd>lua require('config.dap').nvim_dap_load_launchjs()<cr>", "Reload .vscode/launch.json (?!?!)" },
			["<leader>de"] = { "<cmd>lua require('telescope').extensions.dap.commands({})<cr>", "Commands" },
			["<leader>df"] = {
				"<cmd>lua require('telescope').extensions.dap.configurations({})<cr>",
				"Configurations",
			},
			["<leader>dr"] = {
				"<cmd>lua require('telescope').extensions.dap.list_breakpoints({})<cr>",
				"List breakpoints",
			},
			["<leader>dv"] = { "<cmd>lua require('telescope').extensions.dap.variables({})<cr>", "Variables" },
			["<leader>dm"] = { "<cmd>lua require('telescope').extensions.dap.frames({})<cr>", "Frames" },
			["<F8>"] = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
			["<S-F8>"] = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
			["<F7>"] = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
			["<F9>"] = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
			["<S-F9>"] = { "<cmd>lua require('dap-go').debug_test()<cr>", "Continue Test" },
		},
	},
	["dap-go"] = {
		plugin = true,
		n = {
			["<leader>dgt"] = {
				function()
					require("dap-go").debug_test()
				end,
				"Debug go test",
			},
			["<leader>dgl"] = {
				function()
					require("dap-go").debug_last()
				end,
				"Debug last go test",
			},
		},
	},
	gopher = {},
	tabufline = {
		plugin = true,

		n = {
			-- cycle through buffers
			["<S-Right>"] = {
				function()
					require("nvchad.tabufline").tabuflineNext()
				end,
				"Goto next buffer",
			},

			["<S-Left>"] = {
				function()
					require("nvchad.tabufline").tabuflinePrev()
				end,
				"Goto prev buffer",
			},
		},
	},
}

return M
