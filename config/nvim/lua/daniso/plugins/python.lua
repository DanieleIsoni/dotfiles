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
        python = function(bufnr)
          local formatters = { 'ruff_fix' }
          if require('conform').get_formatter_info('black', bufnr).available then
            table.insert(formatters, 'black')
          else
            table.insert(formatters, 'ruff_format')
          end
          return formatters
        end,
      },
    },
  },
}
