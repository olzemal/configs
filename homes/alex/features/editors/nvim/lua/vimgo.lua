-- vim-go
require "lib"

-- vim-go options
vim.g.go_fmt_fail_silently               = 0
vim.g.go_fmt_command                     = 'goimports'
vim.g.go_fmt_autosave                    = 1
vim.g.go_gopls_enabled                   = 1
vim.g.go_highlight_types                 = 1
vim.g.go_highlight_fields                = 1
vim.g.go_highlight_functions             = 1
vim.g.go_highlight_function_calls        = 1
vim.g.go_highlight_operators             = 1
vim.g.go_highlight_extra_types           = 1
vim.g.go_highlight_variable_declarations = 1
vim.g.go_highlight_variable_assignments  = 1
vim.g.go_highlight_build_constraints     = 1
vim.g.go_highlight_diagnostic_errors     = 1
vim.g.go_highlight_diagnostic_warnings   = 1
vim.g.go_auto_type_info                  = 1
vim.g.go_list_type                       = "quickfix"

autocmd({'BufNewFile', 'BufRead'}, {
  pattern = 'go',
  callback = function()
    vim.bo.expandtab  = false
    vim.bo.tabstop    = 4
    vim.bo.shiftwidth = 4
  end
})

autocmd('FileType', {
  pattern = 'go',
  callback = function()
    keymap('n', '<Leader>v', '<cmd>GoVet!<CR>')
    keymap('n', '<Leader>c', '<cmd>GoCoverageToggle<CR>')
    keymap('n', '<Leader>l', '<cmd>GoMetaLinter!<CR>')
  end
})
