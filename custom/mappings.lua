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
				"<Cmd>update<CR>:lua vim.lsp.buf.format()<CR>",
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
			["<leader>db"] = {
				function()
					require("dap").toggle_breakpoint()
				end,
				"Toggle breakpoint",
			},
			["<leader>dc"] = {
				function()
					require("dap").continue()
				end,
				"Continue",
			},
			["<leader>dt"] = {
				function()
					require("dap-go").debug_test()
				end,
				"Continue Test",
			},
			["<leader>ds"] = {
				function()
					require("dap").step_over()
				end,
				"Step over",
			},
			["<leader>di"] = {
				function()
					require("dap").step_into()
				end,
				"Step into",
			},
			["<leader>do"] = {
				function()
					require("dap").step_out()
				end,
				"Step out",
			},
			["<leader>du"] = {
				function()
					require("dapui").toggle()
				end,
				"Toggle UI",
			},
			["<leader>dp"] = {
				function()
					require("dap").repl.open()
				end,
				"Step out",
			},
			-- ["<leader>dl"] = {
			-- 	function()
			-- 		require("config.dap").nvim_dap_load_launchjs()
			-- 	end,
			-- 	"Reload .vscode/launch.json (?!?!)",
			-- },
			["<leader>de"] = {
				function()
					require("telescope").extensions.dap.commands({})
				end,
				"Commands",
			},
			["<leader>df"] = {
				function()
					require("telescope").extensions.dap.configurations({})
				end,
				"Configurations",
			},
			["<leader>dr"] = {
				function()
					require("telescope").extensions.dap.list_breakpoints({})
				end,
				"List breakpoints",
			},
			["<leader>dv"] = {
				function()
					require("telescope").extensions.dap.variables({})
				end,
				"Variables",
			},
			["<leader>dm"] = {
				function()
					require("telescope").extensions.dap.frames({})
				end,
				"Frames",
			},
		},
		v = {
			["<leader>sv"] = {
				"<Cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				"Visual search",
			},
		},
	},
	dap = {
		plugin = true,
		n = {
			["<leader>db"] = {
				"<cmd>DapToggleBreakpoint<CR>",
				"Add breakpoint at line",
			},
			["<leader>dus"] = {
				function()
					local widgets = require("dap.ui.widgets")
					local sidebar = widgets.sidebar(widgets.scopes)
					sidebar.open()
				end,
				"Open debugging sidebar",
			},
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
