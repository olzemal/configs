local persisted = require("persisted")

persisted.setup({
  autostart = true,
  autoload = true,
  use_git_branch = true
})

vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
