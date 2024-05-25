return {
  'hrsh7th/nvim-cmp',
  lazy = false,
  priority = 100,
  dependencies = {
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
    'saadparwaiz1/cmp_luasnip',
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  },
  config = function()
    -- start LSP stuff
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require 'lspconfig'

    local servers = { 'rust_analyzer' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
      }
    end
    -- end

    vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
    vim.opt.shortmess:append 'c'

    local luasnip = require 'luasnip'
    luasnip.config.setup {}
    local lspkind = require 'lspkind'
    lspkind.init {}

    local cmp = require 'cmp'

    cmp.setup {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
      },
      mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping(cmp.mapping.confirm {
          select = true,
        }),
        ['<C-Space>'] = cmp.mapping.complete {},
      },

      -- Enable luasnip to handle snippet expansion for nvim-cmp
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
          -- vim.snippet.expand(args.body)
        end,
      },
    }
  end,
}
