require "lib"

local dap, dapui, dapgo = require("dap"), require("dapui"), require("dap-go")

local cfg = {
  layouts = {
    {
      elements = {
        {
          id = "scopes",
          size = 1
        }
      },
      position = "bottom",
      size = 15
    },
    {
      elements = {
        {
          id = "breakpoints",
          size = 0.33
        }, {
          id = "stacks",
          size = 0.33
        },
        {
          id = "watches",
          size = 0.33
        }
      },
      position = "right",
      size = 50
    },
  }
}

dapui.setup(cfg)
dapgo.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
dap.listeners.before.attach['restore-buf'] = function(session, config)
  vim.g.dap_start_buf = vim.api.nvim_get_current_buf()
end
dap.listeners.before.launch['restore-buf'] = function(session, config)
  vim.g.dap_start_buf = vim.api.nvim_get_current_buf()
end

dap.listeners.after.event_terminated['restore-buf'] = function(session, body)
  if vim.g.dap_start_buf and vim.api.nvim_buf_is_valid(vim.g.dap_start_buf) then
    vim.api.nvim_set_current_buf(vim.g.dap_start_buf)
  end
end
dap.listeners.after.event_exited['restore-buf'] = function(session, body)
  if vim.g.dap_start_buf and vim.api.nvim_buf_is_valid(vim.g.dap_start_buf) then
    vim.api.nvim_set_current_buf(vim.g.dap_start_buf)
  end
end

keymap({'n', 'v', 'i'}, '<C-D>', '<Nop>')

-- keymap('n', '<C-D>b', function() require('dap').toggle_breakpoint() end)
keymap('n', '<C-D>b', function() require('persistent-breakpoints.api').toggle_breakpoint() end)
keymap('n', '<C-D>DB', function() require('persistent-breakpoints.api').clear_all_breakpoints() end)

keymap('n', '<C-D>c', function() require('dap').continue() end)
keymap('n', '<C-D><C-D>', function() require('dap').step_over() end)
keymap('n', '<C-D>i', function() require('dap').step_into({askForTargets = true}) end)
keymap('n', '<C-D>o', function() require('dap').step_out() end)

keymap('n', '<C-D><Up>', function() require('dap').up() end)
keymap('n', '<C-D><Down>', function() require('dap').down() end)

keymap('n', '<C-D>p', function() require('dap').pause() end)
keymap('n', '<C-D>r', function() require('dap').restart() end)
keymap('n', '<C-D>q', function() require('dap').terminate(); require('dapui').close() end)

keymap('n', '<C-D>w', function() require('dapui').elements.watches.add(vim.fn.expand('<cword>')) end)

vim.fn.sign_define('DapBreakpoint', {text='B', texthl='QuickFixLine', linehl='', numhl='QuickFixLine'})
