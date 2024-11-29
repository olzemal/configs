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
      winhighlight = "Normal:transparentBG,FloatBorder:transparentBG,Search:None",
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:transparentBG,FloatBorder:transparentBG,Search:None",
    },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
  },
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
vim.opt.pumblend = 0
