-- Debugger

require "lib"

local dap, dapui, dapgo = require("dap"), require("dapui"), require("dap-go")

dapui.setup()
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

vim.fn.sign_define('DapBreakpoint', {text='B', texthl='QuickFixLine', linehl='', numhl='QuickFixLine'})
