local M = {}

function M.setup(use)
  -- LSP and completion
  use { "williamboman/nvim-lsp-installer" }
  use { "jose-elias-alvarez/null-ls.nvim" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "neovim/nvim-lspconfig",
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
  }

  -- Lua development
  use { "tjdevries/nlua.nvim" }
  use { "folke/lua-dev.nvim", event = "VimEnter" }
  -- use { "simrat39/symbols-outline.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     require("config.symbols-outline").setup()
  --   end,
  -- }

  -- debugging/DAP
  use { "puremourning/vimspector", event = "BufWinEnter" }
  -- DAP
  use { "mfussenegger/nvim-dap", event = "BufWinEnter", as = "nvim-dap" }
  use { "mfussenegger/nvim-dap-python", after = "nvim-dap" }
  use { "theHamsta/nvim-dap-virtual-text",
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup {}
    end,
  }
  use { "rcarriga/nvim-dap-ui", after = "nvim-dap" }
  use { "Pocco81/DAPInstall.nvim", after = "nvim-dap" }
  use { "jbyuki/one-small-step-for-vimkind", after = "nvim-dap" }
end

return M
