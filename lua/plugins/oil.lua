return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    -- Open parent directory in current window
    vim.keymap.set('n', '<space><space>', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    return {
      columns = { 'icon' },
      keymaps = {
        ['<C-h>'] = false,
        ['<space><space>'] = 'actions.close',
      },
      view_options = {
        show_hidden = true,
      },
    }
  end,
}
