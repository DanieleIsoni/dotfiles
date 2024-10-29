local set = vim.keymap.set

set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'E[x]ecute the current line' })
set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'E[x]ecute the current file' })
