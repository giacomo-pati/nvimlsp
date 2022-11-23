local M = {}

function M.setup()
	require("project_nvim").setup({})

	-- vim.g.nvim_tree_respect_buf_cwd = 1

	require("telescope").load_extension("projects")
end

return M
