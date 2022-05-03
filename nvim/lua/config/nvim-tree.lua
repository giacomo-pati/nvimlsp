------------------------------------------------
-- Plugin: pkyazdani42/nvim-tree
------------------------------------------------
local M = {}

function M.setup()
	vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeToggle<cr>", { noremap = true })

	-- each of these are documented in `:help nvim-tree.OPTION_NAME`
	require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
		auto_reload_on_write = true,
		disable_netrw = false,
		hijack_cursor = false,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		ignore_buffer_on_setup = false,
		open_on_setup = false,
		open_on_tab = false,
		sort_by = "name",
		update_cwd = false,
		view = {
			width = 40,
			height = 30,
		  hide_root_folder = false,
			side = "left",
			preserve_window_proportions = false,
			number = false,
			relativenumber = false,
			signcolumn = "yes",
			mappings = {
				custom_only = false,
				list = {
					-- user mappings go here
				},
			},
		},
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = false,
			update_cwd = false,
			ignore_list = {},
		},
		ignore_ft_on_setup = {},
		system_open = {
			cmd = nil,
			args = {},
		},
		diagnostics = {
			enable = false,
			show_on_dirs = false,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		filters = {
			dotfiles = false,
			custom = {},
			exclude = {},
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 400,
		},
		actions = {
			change_dir = {
				enable = true,
				global = false,
			},
			open_file = {
				quit_on_open = true,
				resize_window = false,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
		},
		trash = {
			cmd = "trash",
			require_confirm = true,
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				git = false,
			},
		},
	}) -- END_DEFAULT_OPTS
end
return M
