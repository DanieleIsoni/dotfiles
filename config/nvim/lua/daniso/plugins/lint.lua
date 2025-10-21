-- Linting

return {
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters_by_ft = {
        json = { 'jsonlint' },
        text = { 'vale' },
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'jsonlint', 'vale' } },
  },
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, function()
        local linters = require('lint').get_running()
        if #linters == 0 then
          return '󰦕'
        end
        return '󱉶 local ' .. table.concat(linters, ', ')
      end)
    end,
  },
}
