local M = {}

local lsputils = require "config.lsp.utils"

function M.config()
  local conf = {
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    experimentalPostfixCompletions = true,
    analyses = { unusedparams = true, unreachable = false },
    codelenses = { generate = true, gc_details = true, test = true, tidy = true },
    usePlaceholders = true,
    completeUnimported = true,
    staticcheck = true,
    matcher = "fuzzy",
    experimentalDiagnosticsDelay = "500ms",
    symbolMatcher = "fuzzy",
    gofumpt = true,
    buildFlags = { "-tags", "integration" },
    capabilities = lsputils.get_capabilities(),
    on_attach = lsputils.lsp_attach,
    on_init = lsputils.lsp_init,
    on_exit = lsputils.lsp_exit,
    flags = { debounce_text_changes = 150 },
  }
  return conf
end

function M.setup()
  return M.config()
end

return M
