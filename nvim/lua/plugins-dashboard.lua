local M = {}

function M.setup(use)
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

  use {
    "nvim-lualine/lualine.nvim",
    after = "nvim-treesitter",
    config = function()
      require("config.lualine").setup()
    end,
  }

  use {
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("config.bufferline").setup()
    end,
    event = "BufReadPre",
  }

  -- Filesystem
  if true then
    use { "preservim/nerdtree",
      config = function()
        require("config.nerdtree").setup()
      end,
    }
    use { "Xuyuanp/nerdtree-git-plugin" }
  else
    use { "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.nvim-tree").setup()
      end
    }
  end
  use { "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  }
  use { "windwp/nvim-spectre",
    event = "VimEnter",
    config = function()
      require("spectre").setup()
    end,
  }
  use { "djoshea/vim-autoread" }

end

return M
