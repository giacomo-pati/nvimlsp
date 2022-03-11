local M = {}

function M.setup()
  local dap = require "dap"

  dap.adapters.go = function(callback, config)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local host = config.host or "127.0.0.1"
    local port = config.port or "38697"
    local addr = string.format("%s:%s", host, port)
    local opts = {
      stdio = {nil, stdout},
      args = {"dap", "-l", addr},
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(
      function()
        callback({type = "server", host = "127.0.0.1", port = port})
      end,
      100)
  end
  -- dap.adapters.go = function(callback, config)
  --   local handle, pid_or_err, port = nil, nil, 12346

  --   handle, pid_or_err = vim.loop.spawn(
  --     "dlv",
  --     {
  --       args = { "dap", "-l", "127.0.0.1:" .. port },
  --       detached = true,
  --       cwd = vim.loop.cwd(),
  --     },
  --     vim.schedule_wrap(function(code)
  --       handle:close()
  --       print("Delve has exited with: " .. code)
  --     end)
  --   )

  --   if not handle then
  --     error("FAILED:", pid_or_err)
  --   end

  --   vim.defer_fn(function()
  --     callback { type = "server", host = "127.0.0.1", port = port }
  --   end, 100)
  -- end
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
    }
  }
  -- vim.api.nvim_set_keymap('n', '<F8>', ':lua require'dap'.step_over()<cr>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<S-F8>', ':lua require'dap'.step_out()<cr>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<F7>', ':lua require'dap'.step_into()<cr>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<F9>', ':lua require'dap'.continue()<cr>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('n', '<S-F9>', ':lua require('dap-go').debug_test()<cr>', { noremap = true, silent = true })

end

return M
