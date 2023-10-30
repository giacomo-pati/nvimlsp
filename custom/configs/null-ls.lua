local nullls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local b = nullls.builtins
nullls.setup({
	sources = {
		-- go install mvdan.cc/gofumpt@latest
		b.formatting.gofumpt,
		-- go install github.com/incu6us/goimports-reviser/v3@latest
		b.formatting.goimports_reviser,
		-- go install github.com/segmentio/golines@latest
		-- b.formatting.golines,
		-- webdev stuff
		b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
		b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }), -- so prettier works only on these filetypes
		-- Lua
		b.formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
			-- Remove trailing white spaces on save
			vim.cmd([[autocmd BufWritePre * :%s/\s\+$//e]])
		end
	end,
})
