-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local KeymapUtil = require 'daniso.utils.keymaps'

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = '[L]azy' })

-- Quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit all [q]' })

-- Compare to clipboard
vim.keymap.set('x', '<Leader>cc', KeymapUtil.Compare_to_clipboard, { desc = '[C]ompare to [C]lipboard' })

-- gitlab
vim.keymap.set('n', '<leader>gp', KeymapUtil.Gitlab_pipelines_toggle, { noremap = true, silent = true, desc = '[G]itlab [P]ipeline (current branch)' })
vim.keymap.set('n', '<leader>gm', '<cmd>!glab mr view --web<cr>', { noremap = true, silent = true, desc = '[G]itlab open [M]erge request (current branch)' })

vim.keymap.set('n', 'glf', '<C-w>F', { noremap = true, silent = true, desc = '[G]oto [l] [f]ile under cursor in new split' })
