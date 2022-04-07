local M = {}

function M.setup()
	require("navigator").setup({
		lsp_installer = true, -- set to true if you would like use the lsp installed by williamboman/nvim-lsp-installer
		lsp_signature_help = true,
	})
end
return M
