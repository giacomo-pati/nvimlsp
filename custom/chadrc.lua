---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'catppuccin',
  statusline = { theme = "vscode_colored" },
  nvdash = {
    buttons = {
      { "  Find File", "<leader> f f", "Telescope find_files" },
      { "󰈚  Recent Files", "<leader> f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "<leader> f w", "Telescope live_grep" },
      { "  Bookmarks", "<leader> m a", "Telescope marks" },
      { "  Themes", "<leader> t h", "Telescope themes" },
      { "  Mappings", "<leader> c h", "NvCheatsheet" },
    },
  },
  hl_override = {
    Comment = {
      italic = true,
    },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
