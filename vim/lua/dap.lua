-- Debugger

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

keymap('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
keymap('n', '<Leader>dc', function() require('dap').continue() end)
keymap('n', '<Leader>dd', function() require('dapui').close() end)
