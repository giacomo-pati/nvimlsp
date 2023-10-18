local plugins = {
  { 
    "Pocco81/AutoSave.nvim",
    lazy = false,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "bash-language-server",
        "dockerfile-language-server",
        "lua-language-server",
        "powershell-editor-services",
        "json-lsp", 
        "yaml-language-server", 
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function ()
      local opts = require "plugins.configs.treesitter"
      opts["ensure_installed"] = {
        "lua",
        "python",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "javascript",
        "c",
        "java",
      }
      return opts
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings("nvimtree")
    end,
    opts = function()
      -- return require "plugins.configs.nvimtree"
      return require "custom.configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },
  {
    -- go install github.com/go-delve/delve/cmd/dlv@latest
    "mfussenegger/nvim-dap",
    init = function ()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    -- "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap-go")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function ()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    dependencies = {"nvim-lua/plenary.nvim","nvim-treesitter/nvim-treesitter"},
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      auto_open = true,
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    lazy = false,
    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,
	},
  {
  "folke/which-key.nvim",
  disable = false,
  config = function()
    -- require("plugins.configs.whichkey")
    local present, wk = pcall(require, "which-key")
    if not present then
      return
    end
    wk.register(
      {
        -- add groups
        ["<leader>"] = {
          b = { name = "+Buffer" },
          l = { name = "+LSP" },
        }
      }
    )
  end,
  setup = function()
    require("core.utils").load_mappings "whichkey"
  end,
},
}
return plugins

