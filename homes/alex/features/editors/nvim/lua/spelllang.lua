-- Languages
vim.g.detectspelllang_langs = {
  ['aspell']   = {'en', 'de'},
  ['hunspell'] = {'en', 'de'},
}
vim.g.detectspelllang_lines     = 20 -- Evaluate the first 20 lines of a file
vim.g.detectspelllang_threshold = 20 -- Allow a maximum of 20% misspelled words
