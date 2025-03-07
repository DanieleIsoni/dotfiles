-- Auto save

return {
  {
    'Pocco81/auto-save.nvim',
    lazy = false,
    keys = {
      { '<leader>n', ':ASToggle<CR>', desc = 'Toggle auto save' },
    },
  },
}
