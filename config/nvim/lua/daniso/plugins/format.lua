-- Formatting

return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        ruff_fix = {
          append_args = { '--unsafe-fixes' },
        },
      },
      formatters_by_ft = {
        json = { 'prettier' },
        python = function(bufnr)
          local formatters = { 'ruff_fix' }
          if require('conform').get_formatter_info('black', bufnr).available then
            table.insert(formatters, 'black')
          else
            table.insert(formatters, 'ruff_format')
          end
          return formatters
        end,
        yaml = { 'yamlfmt' },
        ['_'] = { 'trim_whitespace' },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'prettier', 'yamlfmt' } },
  },
}
