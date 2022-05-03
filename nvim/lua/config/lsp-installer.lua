local M = {}

function M.setup()
  vim.api.nvim_create_user_command("LspLog", [[exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()")]], {})

  require("nvim-lsp-installer").setup {
      ensure_installed = { "sumneko_lua", "jsonls", "yamlls", "gopls" },
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
	-- local lsp_installer = require("nvim-lsp-installer")

	-- local enhance_server_opts = {
	-- 	["sumneko_lua"] = function(options)
	-- 		options.settings = {
	-- 			Lua = {
	-- 				diagnostics = {
	-- 					globals = { "vim" },
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- 	["tsserver"] = function(options)
	-- 		options.on_attach = function(client)
	-- 			client.server_capabilities.document_formatting = false
	-- 		end
	-- 	end,
	-- }

	-- lsp_installer.on_server_ready(function(server)
	-- 	local options = {}

	-- 	if enhance_server_opts[server.name] then
	-- 		enhance_server_opts[server.name](options)
	-- 	end
	-- end)
end

return M
