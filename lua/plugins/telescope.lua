return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-smart-history.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').setup {
      extensions = {
        wrap_results = true,

        fzf = {},
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'smart_history')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<space>sf', builtin.find_files)
    vim.keymap.set('n', '<space>sg', builtin.git_files)
    vim.keymap.set('n', '<space>st', builtin.help_tags)
    vim.keymap.set('n', '<space>sw', builtin.live_grep)
    vim.keymap.set('n', '<space>/', builtin.current_buffer_fuzzy_find)

    -- vim.keymap.set("n", "<space>gw", builtin.grep_string)

    -- vim.keymap.set("n", "<space>fa", function()
    --   ---@diagnostic disable-next-line: param-type-mismatch
    --   builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
    -- end)

    vim.keymap.set('n', '<space>sc', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end)
  end,
}
