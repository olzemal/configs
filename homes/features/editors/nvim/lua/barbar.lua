require "lib"

vim.g.barbar_auto_setup = false

local barbar = require("barbar")

barbar.setup{
  clickable = true,
  tabpages = false,
  auto_hide = 1,
  insert_at_end = true,
  icons = {
    buffer_index = true,
    filetype = { enabled = false },
  }
}

local opts = {noremap = true, silent = true}
local modes = {"n", "t"}

keymap(modes, "<A-Left>", "<Cmd>BufferPrevious<CR>", opts)
keymap(modes, "<A-Right>", "<Cmd>BufferNext<CR>", opts)

keymap(modes, "<A-S-Left>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap(modes, "<A-S-Right>", "<Cmd>BufferMoveNext<CR>", opts)

keymap(modes, "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
keymap(modes, "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
keymap(modes, "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
keymap(modes, "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
keymap(modes, "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
keymap(modes, "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
keymap(modes, "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
keymap(modes, "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
keymap(modes, "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
keymap(modes, "<A-0>", "<Cmd>BufferLast<CR>", opts)

keymap(modes, "<A-c>", "<Cmd>BufferClose<CR>", opts)
keymap(modes, "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)

keymap(modes, "<A-p>", "<Cmd>BufferPin<CR>", opts)

keymap("n", "<A-t>", function()
  vim.cmd("belowright terminal")
  vim.cmd("startinsert")
end, opts)

autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight! link TrailingWhitespace Normal")
  end,
})

keymap("t", "<C-d>", "<C-d>", { noremap = true, silent = true })
