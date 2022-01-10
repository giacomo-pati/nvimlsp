local M = {}

function M.setup(use)
  -- LSP and completion
use { "williamboman/nvim-lsp-installer" }
use { "jose-elias-alvarez/null-ls.nvim" }
use { "neovim/nvim-lspconfig",
    as = "nvim-lspconfig",
    -- after = { "nvim-treesitter", "nvim-lsp-installer", "cmp"},
    opt = true,
    requires = {
      "ray-x/lsp_signature.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("config.lsp").setup()
      -- require("config.dap").setup()
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

  -- Completion
  use { "hrsh7th/nvim-cmp",
    as = "cmp",
    -- after = "nvim-treesitter",
    opt = true,
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      -- "quangnguyen30192/cmp-nvim-ultisnips",
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
  }
  use { "tami5/lspsaga.nvim",
    config = function()
      require("config.lspsaga").setup()
    end,
  }
  use { "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init()
    end,
  }
end

return M
