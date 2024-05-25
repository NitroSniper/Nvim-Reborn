return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'ruff_fix', 'ruff_format' },
      -- Use a sub-list to run only the first available formatter
      javascript = {},
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        -- return
      end
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
  },
}
