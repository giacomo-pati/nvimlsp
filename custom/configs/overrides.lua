local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
    "python",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "javascript",
    "c",
    "java",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    "gopls",
    "bash-language-server",
    "dockerfile-language-server",
    "lua-language-server",
    "powershell-editor-services",
    "json-lsp",
    "yaml-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  view = {
    width = 50, -- MODIFIED
  },
  update_focused_file = {
    enable = true, -- MODIFIED
  },
  filters = {
    git_ignored = false, -- MODIFIED
  },
  actions = {
    open_file = {
      quit_on_open = true, -- MODIFIED
    },
  },
  tab = {
    sync = {
      open = true, -- MODIFIED
    },
  },
}

return M
