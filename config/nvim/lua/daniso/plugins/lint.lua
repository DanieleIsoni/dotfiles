return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      local linters_by_ft = lint.linters_by_ft or {}
      linters_by_ft = vim.tbl_deep_extend('force', linters_by_ft, {
        clojure = nil, -- { "clj-kondo" },
        dockerfile = { 'hadolint' },
        go = { 'golangci_lint' },
        inko = nil, -- { "inko" },
        janet = nil, -- { "janet" },
        json = { 'jsonlint' },
        markdown = { 'markdownlint' },
        rst = nil, -- { "vale" },
        ruby = nil, -- { "ruby" },
        terraform = { 'tflint' },
        text = { 'vale' },
      })

      lint.linters_by_ft = linters_by_ft

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- lualine
      require('daniso.utils.lualine').insert_elements('lualine_x', {
        function()
          local linters = require('lint').get_running()
          if #linters == 0 then
            return '󰦕'
          end
          return '󱉶 local ' .. table.concat(linters, ', ')
        end,
      })
    end,
  },
}
