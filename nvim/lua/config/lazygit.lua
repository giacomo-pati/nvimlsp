local M = {}

function M.setup()
	vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
	vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
	vim.g.lazygit_floating_window_border_chars = { "╭", "╮", "╰", "╯" } -- customize lazygit popup window corner characters
	vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
	vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

	-- register every git root
	-- vim.cmd("autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()")
end

return M
