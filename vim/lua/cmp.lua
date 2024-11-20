-- Buffer Completion
local cmp = require'cmp'
cmp.register_source('emoji', require'cmp_emoji'.new())

cmp.setup({
  enabled = true,
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:NormalFloat",
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:NormalFloat",
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'emoji' },
  }, {
    { name = 'buffer' },
  })
})

-- cmdline completion
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.opt.completeopt:append('menuone')
vim.opt.completeopt:append('noselect')
vim.opt.shortmess:append('c')
vim.opt.previewheight = 5
