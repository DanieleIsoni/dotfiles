-- Better diff

return {
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>dd', ':DiffviewOpen<CR>', desc = '[D]iffview [D]iff' },
      { '<leader>dh', ':DiffviewFileHistory<CR>', desc = '[D]iffview File [H]istory' },
      { '<leader>df', ':DiffviewFileHistory %<CR>', desc = '[D]iffview File History (current [F]ile)' },
    },
  },
}
