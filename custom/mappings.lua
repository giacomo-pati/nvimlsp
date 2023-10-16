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
      }
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
  }

}



return M
