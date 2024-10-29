return {
  {
    'ranelpadon/python-copy-reference.vim',
    config = function()
      require('which-key').add {
        { '<leader>r', group = 'Copy [R]eference' },
      }

      vim.keymap.set('n', '<Leader>rd', ':PythonCopyReferenceDotted<CR>', { desc = 'Copy [R]eference [D]otted' })
      vim.keymap.set('n', '<Leader>rp', ':PythonCopyReferencePytest<CR>', { desc = 'Copy [R]eference [P]ytest' })
      vim.keymap.set('n', '<Leader>ri', ':PythonCopyReferenceImport<CR>', { desc = 'Copy [R]eference [I]mport' })
    end,
  },
}
