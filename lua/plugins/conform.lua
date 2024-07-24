return {
  'stevearc/conform.nvim',
  opts = function()
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting globally
        vim.g.disable_autoformat = true
      else
        -- FormatDisable will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    return {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'ruff_fix', 'ruff_format' },
        -- Use a sub-list to run only the first available formatter
        javascript = {},
        nix = { 'nixfmt' },
        jsonc = { 'jq' }, -- doesn't support comments
        html = { 'djlint' },
        htmldjango = { 'djlint' },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
    }
  end,
}
