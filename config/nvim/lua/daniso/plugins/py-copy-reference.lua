require('which-key').add {
  { '<leader>r', group = 'Copy [R]eference', icon = '' },
}

return {
  {
    'ranelpadon/python-copy-reference.vim',
    config = function()
      vim.keymap.set('n', '<Leader>cyd', ':PythonCopyReferenceDotted<CR>', { desc = '[C]ode [Y]ank Reference [D]otted' })
      vim.keymap.set('n', '<Leader>cyp', ':PythonCopyReferencePytest<CR>', { desc = '[C]ode [Y]ank Reference [P]ytest' })
      vim.keymap.set('n', '<Leader>cyi', ':PythonCopyReferenceImport<CR>', { desc = '[C]ode [Y]ank Reference [I]mport' })
    end,
  },
}
