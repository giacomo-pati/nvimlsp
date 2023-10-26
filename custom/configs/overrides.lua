local M = {}

M.treesitter = {
	ensure_installed = {
		"c",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"java",
		"javascript",
		"lua",
		"markdown",
		"python",
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
		"bash-language-server",
		"dockerfile-language-server",
		"gopls",
		"json-lsp",
		"lua-language-server",
		"powershell-editor-services",
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
