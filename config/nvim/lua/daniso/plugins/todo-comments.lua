-- Highlight todo, notes, etc in comments

return {
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'VimEnter',
    opts = { signs = false },
    keys = function()
      require('which-key').add {
        { '<leader>x', group = 'diagnostics/quickfi[x]', icon = { icon = '󱖫 ', color = 'green' } },
      }
      return {
        {
          ']t',
          function()
            require('todo-comments').jump_next()
          end,
          desc = '[]] Next [T]odo Comment',
        },
        {
          '[t',
          function()
            require('todo-comments').jump_prev()
          end,
          desc = '[[] Previous [T]odo Comment',
        },
        { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = '[x] [T]odo (Trouble)' },
        { '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = '[x] [T]odo/Fix/Fixme (Trouble)' },
        { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odo' },
        { '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = '[S]earch [T]odo/Fix/Fixme' },
      }
    end,
  },
}
