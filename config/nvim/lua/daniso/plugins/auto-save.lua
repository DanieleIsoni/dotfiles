-- Auto save
return {
  {
    'Pocco81/auto-save.nvim',
    config = function()
      vim.keymap.set('n', '<leader>n', ':ASToggle<CR>', { desc = 'Toggle auto save' })
    end,
  },
}
