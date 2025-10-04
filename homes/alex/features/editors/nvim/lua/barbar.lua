require("lib")

vim.g.barbar_auto_setup = false

local barbar = require("barbar")

barbar.setup({
  clickable = true,
  tabpages = false,
  auto_hide = 1,
  insert_at_end = true,
  icons = {
    buffer_index = true,
    filetype = { enabled = false },
    gitsigns = {
      added = { enabled = true, icon = "+" },
      changed = { enabled = true, icon = "~" },
      deleted = { enabled = true, icon = "-" }
    }
  }
})

local opts = {noremap = true, silent = true}

keymap("n", "<A-Left>", "<Cmd>BufferPrevious<CR>", opts)
keymap("n", "<A-Right>", "<Cmd>BufferNext<CR>", opts)

keymap("n", "<A-S-Left>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap("n", "<A-S-Right>", "<Cmd>BufferMoveNext<CR>", opts)

keymap("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
keymap("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
keymap("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
keymap("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
keymap("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
keymap("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
keymap("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
keymap("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
keymap("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
keymap("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

keymap("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
keymap("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)

keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
