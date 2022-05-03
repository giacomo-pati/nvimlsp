local M = {}

local function setup_servers()
  -- require("config.lsp.null-ls").setup()
  local lspconfig = require("lspconfig")
  local lsputils = require("config.lsp.utils")
  local gopls_opts = require("config.lsp.gopls").setup()
  lsputils.setup_server("gopls", gopls_opts)

  require("config.lsp.null-ls").setup()
end

function M.setup()
  setup_servers()
end

return M
