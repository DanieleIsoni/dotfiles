return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      words = { enabled = true },
    },
    keys = function()
      require('which-key').add { { '<leader>b', group = '[B]uffer' } }
      return {
        {
          '<leader>bd',
          function()
            Snacks.bufdelete()
          end,
          desc = '[B]uffer [D]elete',
        },
        {
          '<leader>gf',
          function()
            Snacks.lazygit.log_file()
          end,
          desc = 'Lazygit Current File History',
        },
        {
          '<leader>gg',
          function()
            Snacks.lazygit()
          end,
          desc = 'Lazygit',
        },
        {
          '<leader>gl',
          function()
            Snacks.lazygit.log()
          end,
          desc = 'Lazygit Log (cwd)',
        },
      }
    end,
  },
}
