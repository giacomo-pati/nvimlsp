local M = {}

local function setup_servers()
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

	local lspconfig = require("lspconfig")
	local lsputils = require("config.lsp.utils")
	
	-- GOLANG
	lsputils.setup_server("gopls", {
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    experimentalPostfixCompletions = true,
    analyses = { unusedparams = true, unreachable = false },
    codelenses = { generate = true, gc_details = true, test = true, tidy = true },
    usePlaceholders = true,
    completeUnimported = true,
    staticcheck = true,
    matcher = "fuzzy",
    experimentalDiagnosticsDelay = "500ms",
    symbolMatcher = "fuzzy",
    gofumpt = true,
    buildFlags = { "-tags", "integration" },
    capabilities = lsputils.get_capabilities(),
    on_attach = lsputils.lsp_attach,
    on_init = lsputils.lsp_init,
    on_exit = lsputils.lsp_exit,
    flags = { debounce_text_changes = 150 },
  })

	-- JSON
	lsputils.setup_server("jsonls", {})

	-- YAML
	lsputils.setup_server("yamlls", {})

	-- POWERSHELL
	lsputils.setup_server("powershell_es", {})

	-- BASH
	lsputils.setup_server("bashls", {})

	-- DOCKER
	lsputils.setup_server("dockerls", {})

	require("config.lsp.null-ls").setup()
end

function M.setup()
	setup_servers()
end

return M
