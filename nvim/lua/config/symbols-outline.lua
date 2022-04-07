local M = {}

function M.setup()
	vim.api.nvim_set_keymap("n", "<F3>", "<Cmd>SymbolsOutline<CR>", { noremap = true })
	vim.g.symbols_outline = {
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false, -- experimental
		position = "right",
		keymaps = {
			close = "<Esc>",
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			rename_symbol = "r",
			code_actions = "a",
		},
		lsp_blacklist = {},
	}
end

return M
