local M = {}

function M.setup()
  local dap = require "dap"

  dap.adapters.go = function(callback, config)
    local handle, pid_or_err, port = nil, nil, 12346

    handle, pid_or_err = vim.loop.spawn(
      "dlv",
      {
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true,
        cwd = vim.loop.cwd(),
      },
      vim.schedule_wrap(function(code)
        handle:close()
        print("Delve has exited with: " .. code)
      end)
    )

    if not handle then
      error("FAILED:", pid_or_err)
    end

    vim.defer_fn(function()
      callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
  end

  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug Package",
      request = "launch",
      program = "${fileDirname}",
    },
    {
      type = "go",
      name = "Attach",
      mode = "local",
      request = "attach",
      processId = require('dap.utils').pick_process,
    },
    {
      type = "go",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
    {
      type = "go",
      name = "Debug dlv",
      request = "launch",
      showLog = true,
      program = "${file}",
      -- console = "externalTerminal",
      dlvToolPath = vim.fn.exepath "dlv",
    },
    {
      name = "Test Current File dlv",
      type = "go",
      request = "launch",
      showLog = true,
      mode = "test",
      program = "${file}",
      dlvToolPath = vim.fn.exepath "dlv",
    },
  }
  -- vim.api.nvim_set_keymap('n', '<F8>', ':lua require'dap'.step_over()<cr>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<S-F8>', ':lua require'dap'.step_out()<cr>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<F7>', ':lua require'dap'.step_into()<cr>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<F9>', ':lua require'dap'.continue()<cr>', { noremap = true, silent = true })
end

return M
