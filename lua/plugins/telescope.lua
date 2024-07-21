return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-smart-history.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'smart_history')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<space>ss', builtin.builtin)
    vim.keymap.set('n', '<space>sf', builtin.find_files)
    vim.keymap.set('n', '<space>sg', builtin.git_files)
    vim.keymap.set('n', '<space>st', builtin.help_tags)
    vim.keymap.set('n', '<space>sw', builtin.live_grep)
    vim.keymap.set('n', '<space>/', builtin.current_buffer_fuzzy_find)

    vim.keymap.set('n', '<space>sc', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end)

    -- Lsp stuff

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('nitro-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', builtin.lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- vim.keymap.set("n", "<space>gw", builtin.grep_string)

        -- vim.keymap.set("n", "<space>fa", function()
        --   ---@diagnostic disable-next-line: param-type-mismatch
        --   builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
        -- end)

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
      end,
    })

    return {
      extensions = {
        wrap_results = true,

        fzf = {},
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    }
  end,
}
