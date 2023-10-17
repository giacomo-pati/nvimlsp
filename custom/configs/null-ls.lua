
local nullls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local opts = {
  sources = {
    -- go install mvdan.cc/gofumpt@latest
    nullls.builtins.formatting.gofumpt,
    -- go install github.com/incu6us/goimports-reviser/v3@latest
    nullls.builtins.formatting.goimports_reviser,
    -- go install github.com/segmentio/golines@latest
    nullls.builtins.formatting.golines,
  },
  on_attach = function (client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre",{
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({bufnr = bufnr })
        end,
      })
      -- Remove trailing white spaces on save
      -- vim.cmd([[autocmd BufWritePre * :%s/\s\+$//e]])
    end
  end,
}
return opts
