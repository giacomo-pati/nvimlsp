------------------------------------------------
-- Plugin: pkyazdani42/nvim-tree
------------------------------------------------
local M = {}
local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

function M.setup()
	vim.api.nvim_set_keymap("n", "<C-a>", ":NvimTreeToggle<cr>", { noremap = true })
	local api = require("nvim-tree.api")
	local on_attach = function(bufnr)
		local opts = function(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		-- Default mappings. Feel free to modify or remove as you wish.
		--
		-- BEGIN_DEFAULT_ON_ATTACH
		vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
		vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
		vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
		vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
		vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
		vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
		vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
		vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
		vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
		vim.keymap.set("n", "a", api.fs.create, opts("Create"))
		vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
		vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
		vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
		vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
		vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
		vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
		vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
		vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
		vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
		vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
		vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
		vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
		vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
		vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
		vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
		vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
		vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
		vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
		vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
		vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
		vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
		vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
		vim.keymap.set("n", "q", api.tree.close, opts("Close"))
		vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
		vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
		vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
		vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
		vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
		vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
		vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
		vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
		vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
		vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
		-- END_DEFAULT_ON_ATTACH

		-- Mappings removed via:
		--   remove_keymaps
		--   OR
		--   view.mappings.list..action = ""
		--
		-- The dummy set before del is done for safety, in case a default mapping does not exist.
		--
		-- You might tidy things by removing these along with their default mapping.
		-- vim.keymap.set("n", "O", "", { buffer = bufnr })
		-- vim.keymap.del("n", "O", { buffer = bufnr })
		vim.keymap.set("n", "<2-RightMouse>", "", { buffer = bufnr })
		vim.keymap.del("n", "<2-RightMouse>", { buffer = bufnr })
		-- vim.keymap.set("n", "D", "", { buffer = bufnr })
		-- vim.keymap.del("n", "D", { buffer = bufnr })
		-- vim.keymap.set("n", "E", "", { buffer = bufnr })
		-- vim.keymap.del("n", "E", { buffer = bufnr })

		-- Mappings migrated from view.mappings.list
		--
		-- You will need to insert "your code goes here" for any mappings with a custom action_cb
		-- vim.keymap.set("n", "A", api.tree.expand_all, opts("Expand All"))
		-- vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
		-- vim.keymap.set("n", "P", function()
		-- 	local node = api.tree.get_node_under_cursor()
		-- 	print(node.absolute_path)
		-- end, opts("Print Node Path"))

		-- vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
	end
	-- each of these are documented in `:help nvim-tree.OPTION_NAME`
	require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
		on_attach = on_attach, -- MODIFIED
		hijack_cursor = false,
		auto_reload_on_write = true,
		disable_netrw = false,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		root_dirs = {},
		prefer_startup_root = false,
		sync_root_with_cwd = false,
		reload_on_bufenter = false,
		respect_buf_cwd = false,
		select_prompts = false,
		sort = {
			sorter = "name",
			folders_first = true,
			files_first = false,
		},
		view = {
			centralize_selection = false,
			cursorline = true,
			debounce_delay = 15,
			side = "left",
			preserve_window_proportions = false,
			number = false,
			relativenumber = false,
			signcolumn = "yes",
			width = 50, -- MODIFIED
			float = {
				enable = false, -- MODIFIED
				quit_on_focus_loss = true,
				open_win_config = function() -- MODIFIED STRAT
					local screen_w = vim.opt.columns:get()
					local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
					local window_w = screen_w * WIDTH_RATIO
					local window_h = screen_h * HEIGHT_RATIO
					local window_w_int = math.floor(window_w)
					local window_h_int = math.floor(window_h)
					local center_x = (screen_w - window_w) / 2
					local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
					return {
						border = "rounded",
						relative = "editor",
						row = center_y,
						col = center_x,
						width = window_w_int,
						height = window_h_int,
					}
				end, -- MODIFIED END
			},
		},
		renderer = {
			add_trailing = false,
			group_empty = false,
			full_name = false,
			root_folder_label = ":~:s?$?/..?",
			indent_width = 2,
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
			symlink_destination = true,
			highlight_git = false,
			highlight_diagnostics = false,
			highlight_opened_files = "none",
			highlight_modified = "none",
			highlight_bookmarks = "none",
			highlight_clipboard = "name",
			indent_markers = {
				enable = false,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					bottom = "─",
					none = " ",
				},
			},
			icons = {
				web_devicons = {
					file = {
						enable = true,
						color = true,
					},
					folder = {
						enable = false,
						color = true,
					},
				},
				git_placement = "before",
				modified_placement = "after",
				diagnostics_placement = "signcolumn",
				bookmarks_placement = "signcolumn",
				padding = " ",
				symlink_arrow = " ➛ ",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
					modified = true,
					diagnostics = true,
					bookmarks = true,
				},
				glyphs = {
					default = "",
					symlink = "",
					bookmark = "󰆤",
					modified = "●",
					folder = {
						arrow_closed = "",
						arrow_open = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = true, -- MODIFIED
			update_root = false,
			ignore_list = {},
		},
		system_open = {
			cmd = "",
			args = {},
		},
		git = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
			disable_for_dirs = {},
			timeout = 400,
		},
		diagnostics = {
			enable = false,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 50,
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		modified = {
			enable = false,
			show_on_dirs = true,
			show_on_open_dirs = true,
		},
		filters = {
			git_ignored = false, -- MODIFIED
			dotfiles = false,
			git_clean = false,
			no_buffer = false,
			custom = {},
			exclude = {},
		},
		live_filter = {
			prefix = "[FILTER]: ",
			always_show_folders = true,
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 50,
			ignore_dirs = {},
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			expand_all = {
				max_folder_discovery = 300,
				exclude = {},
			},
			file_popup = {
				open_win_config = {
					col = 1,
					row = 1,
					relative = "cursor",
					border = "shadow",
					style = "minimal",
				},
			},
			open_file = {
				quit_on_open = true, -- MODIFIED
				eject = true,
				resize_window = true,
				window_picker = {
					enable = true,
					picker = "default",
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
			remove_file = {
				close_window = true,
			},
		},
		trash = {
			cmd = "gio trash",
		},
		tab = {
			sync = {
				open = true, -- MODIFIED
				close = false,
				ignore = {},
			},
		},
		notify = {
			threshold = vim.log.levels.INFO,
			absolute_path = true,
		},
		ui = {
			confirm = {
				remove = true,
				trash = true,
			},
		},
		experimental = {},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				dev = false,
				diagnostics = false,
				git = false,
				profile = false,
				watcher = false,
			},
		},
	}) -- END_DEFAULT_OPTS
	-- auto close MODIFIED
	local function is_modified_buffer_open(buffers)
		for _, v in pairs(buffers) do
			if v.name:match("NvimTree_") == nil then
				return true
			end
		end
		return false
	end

	vim.api.nvim_create_autocmd("BufEnter", {
		nested = true,
		callback = function()
			if
				#vim.api.nvim_list_wins() == 1
				and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
				and is_modified_buffer_open(vim.fn.getbufinfo({ bufmodified = 1 })) == false
			then
				vim.cmd("quit")
			end
		end,
	})
end
return M
