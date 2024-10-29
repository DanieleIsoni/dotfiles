-- Test runner

return {
  {
    'nvim-neotest/neotest',
    -- opts = function(_, opts)
    --   opts.log_level = vim.log.levels.DEBUG
    -- end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-neotest/neotest-python',
    },
    config = function(_, opts)
      require('neotest').setup(vim.tbl_deep_extend('force', opts, {
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            require('trouble').open { mode = 'quickfix', focus = false }
          end,
        },
        adapters = {
          require 'neotest-python' {},
        },
      }))
    end,
    keys = {
      {
        '<leader>tf',
          -- stylua: ignore
          function() require('neotest').run.run(vim.fn.expand '%') end,
        desc = '[T]est Run [F]ile',
      },
      {
        '<leader>tT',
          -- stylua: ignore
          function() require('neotest').run.run(vim.uv.cwd()) end,
        desc = '[T]est Run All [T]est Files',
      },
      {
        '<leader>tr',
          -- stylua: ignore
          function() require('neotest').run.run() end,
        desc = '[T]est [R]un Nearest',
      },
      {
        '<leader>tl',
          -- stylua: ignore
          function() require('neotest').run.run_last() end,
        desc = '[T]est Run [L]ast',
      },
      {
        '<leader>ts',
          -- stylua: ignore
          function() require('neotest').summary.toggle() end,
        desc = '[T]est Toggle [S]ummary',
      },
      {
        '<leader>to',
          -- stylua: ignore
          function() require('neotest').output.open { enter = true, auto_close = true } end,
        desc = '[T]est Show [O]utput',
      },
      {
        '<leader>tO',
          -- stylua: ignore
          function() require('neotest').output_panel.toggle() end,
        desc = '[T]est Toggle [O]utput Panel',
      },
      {
        '<leader>tS',
          -- stylua: ignore
          function() require('neotest').run.stop() end,
        desc = '[T]est [S]top',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap', suite = false }
        end,
        desc = '[T]est [D]ebug Nearest',
      },

      -- { '<leader>tur', function() require('neotest').run.run({suite=false, extra_args={'-u'}}) end, desc = 'Run Nearest with udpate Snap' },
      -- { '<leader>tuf', function() require('neotest').run.run({vim.fn.expand('%'), suite=false, extra_args={'-u'}}) end, desc = 'Run File with udpate Snap' },
    },
  },
  {
    'andythigpen/nvim-coverage',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function()
      require('which-key').add { { '<leader>tc', group = '[T]est' } }

      return {
        { '<leader>tcc', '<cmd>Coverage<cr>', desc = '[T]est Load and Show [C]overage [c]' },
        { '<leader>tch', '<cmd>CoverageHide<cr>', desc = '[T]est [C]overage [H]ide' },
      }
    end,
    config = function()
      require('coverage').setup()
    end,
  },
}
