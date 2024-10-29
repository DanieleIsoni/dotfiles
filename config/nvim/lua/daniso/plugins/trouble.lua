return {
  {
    'folke/trouble.nvim',
    config = function()
      local trouble = require 'trouble'
      local symbols = trouble.statusline {
        mode = 'symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      }

      local lualine_opts = require('lualine').get_config()
      table.insert(lualine_opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
      require('lualine').setup(lualine_opts)
    end,
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cy', '<cmd>Trouble symbols toggle<cr>', desc = '[C]ode S[y]mbols (Trouble)' },
      { '<leader>xS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = '[Q]uickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
  },
}
