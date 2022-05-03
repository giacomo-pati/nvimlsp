local M = {}

function M.setup()
  local lsputils = require("config.lsp.utils")
	local nls = require("null-ls")
	local sources = {
		nls.builtins.formatting.prettierd.with({
			filetypes = { "html", "javascript", "json", "typescript", "markdown" },
		}),
		nls.builtins.formatting.eslint_d,
		nls.builtins.diagnostics.shellcheck,
		nls.builtins.formatting.stylua,
		nls.builtins.formatting.black,
		nls.builtins.diagnostics.flake8,
		nls.builtins.code_actions.gitsigns,
		-- nls.builtins.formatting.prettier,
		-- nls.builtins.diagnostics.markdownlint,
		-- nls.builtins.diagnostics.vale,
	}
	nls.setup({
		sources = sources,
		on_attach = lsputils.lsp_attach,
		on_exit = lsputils.lsp_exit,
		on_init = lsputils.lsp_init,
		capabilities = lsputils.get_capabilities(),
		flags = { debounce_text_changes = 150 },
	})
end

return M
