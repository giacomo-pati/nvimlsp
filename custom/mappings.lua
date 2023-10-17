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
		    "<Cmd>lua require('toggle').mode()<CR>",
        "Trouble",
      },
      ["<leader>ll"] = {
		    "<Cmd>SymbolsOutline<CR>",
        "Outlines",
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
        "Add breakpoint at line"
      },
      ["<leader>dus"] = {
        function ()
          local widgets = require('dap.ui.widgets');
          local sidebar = widgets.sidebar(widgets.scopes);
          sidebar.open();
        end,
        "Open debugging sidebar"
      },
    },
  },
  ["dap-go"] = {
    plugin = true,
    n = {
      ["<leader>dgt"] = {
        function ()
          require('dap-go').debug_test()
        end,
        "Debug go test"
      },
      ["<leader>dgl"] = {
        function ()
          require('dap-go').debug_last()
        end,
        "Debug last go test"
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
