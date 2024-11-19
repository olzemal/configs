-- LSP
local lspconfig = require('lspconfig')
require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})
