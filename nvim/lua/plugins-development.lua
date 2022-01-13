local M = {}

function M.setup(use)
  use { "tpope/vim-fugitive" }
  use { "tpope/vim-surround" }
  use { "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } }
  use { "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("config.comment").setup()
    end,
  }
  use { "tpope/vim-rhubarb" }
  use { "tpope/vim-unimpaired" }
  use { "tpope/vim-vinegar" }
  use { "tpope/vim-sleuth" }
  use { "wellle/targets.vim" }
  use { "easymotion/vim-easymotion" }
  use { "lewis6991/gitsigns.nvim",
    -- event = "BufReadPre",
    -- wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
  }
  use { "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("config.neogit").setup()
    end,
  }
  -- use { "zeertzjq/which-key.nvim", -- fixes issue https://github.com/folke/which-key.nvim/issues/226
  use { "folke/which-key.nvim",
    -- branch = "patch-1",
    config = function()
      -- require("which-key").setup{}
      require("config.whichkey").setup()
    end,
  }
  -- Project settings
  use { "ahmedkhalf/project.nvim",
    event = "VimEnter",
    config = function()
      require("config.project").setup()
    end,
  }
  use { "iamcco/markdown-preview.nvim", 
    run = 'cd app && yarn install',
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  }
  use { "plasticboy/vim-markdown",
    event = "VimEnter",
    ft = "markdown",
    requires = { "godlygeek/tabular" },
  }
  -- use { "rmagatti/session-lens",
  --   requires = { "rmagatti/auto-session" },
  --   config = function()
  --     require("config.auto-session").setup()
  --     require("session-lens").setup {}
  --   end,
  -- }

  -- Workflows
  use { "voldikss/vim-browser-search", event = "VimEnter" }
  use { "tyru/open-browser.vim", event = "VimEnter" }
  use { "michaelb/sniprun",
    cmd = { "SnipRun" },
    run = "bash install.sh",
    config = function()
      require("config.sniprun").setup()
    end,
  }

  -- Testing
  use {
    "rcarriga/vim-ultest",
    config = "require('config.test').setup()",
    run = ":UpdateRemotePlugins",
    requires = { "vim-test/vim-test" },
  }
end

return M
