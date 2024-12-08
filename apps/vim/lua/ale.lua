-- Ale settings
vim.g.ale_fixers = {
  ['*']  = {'remove_trailing_lines', 'trim_whitespace'},
  ['sh'] = {'shfmt'},
  ['go'] = {'gofmt'}
}
vim.g.ale_linters = {
  ['sh']   = {''},
  ['go']   = {'gofmt'},
  ['yaml'] = {'yamllint'}
}
vim.g.ale_fix_on_save = 1
