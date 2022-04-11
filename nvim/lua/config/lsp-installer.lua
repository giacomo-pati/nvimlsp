local M = {}

function M.setup()
	local lsp_installer = require("nvim-lsp-installer")

	local enhance_server_opts = {
		["sumneko_lua"] = function(options)
			options.settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			}
		end,
		["tsserver"] = function(options)
			options.on_attach = function(client)
				client.resolved_capabilities.document_formatting = false
			end
		end,
	}

	lsp_installer.on_server_ready(function(server)
		local options = {}

		if enhance_server_opts[server.name] then
			enhance_server_opts[server.name](options)
		end
	end)
end

return M
