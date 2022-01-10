local M = {}

function M.setup(use)
  -- LSP and completion
use { "williamboman/nvim-lsp-installer" }
use { "jose-elias-alvarez/null-ls.nvim" }
use { "neovim/nvim-lspconfig",
    as = "nvim-lspconfig",
    after = { "nvim-treesitter", "nvim-lsp-installer", "cmp" },
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
end

return M
