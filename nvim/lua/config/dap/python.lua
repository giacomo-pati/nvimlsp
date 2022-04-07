local M = {}

function M.setup()
	require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
end

return M
