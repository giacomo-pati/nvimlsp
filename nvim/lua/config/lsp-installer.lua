local M = {}

function M.setup()
  vim.api.nvim_create_user_command("LspLog", [[exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()")]], {})

  require("nvim-lsp-installer").setup {
      ensure_installed = { "dockerls", "sumneko_lua", "jsonls", "yamlls", "gopls", "powershell_es", "bashls" },
      automatic_installation = true,
      log_level = vim.log.levels.DEBUG,
      ui = {
          icons = {
              server_installed = "",
              server_pending = "",
              server_uninstalled = "",
          },
      },
  }
end

return M
