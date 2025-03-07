local KeymapUtil = require 'daniso.utils.keymaps'
local set = vim.keymap.set
local del = vim.keymap.del

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Lazy
set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = '[L]azy' })

-- Quit
set('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit all [q]' })

-- Compare to clipboard
set('x', '<Leader>cc', KeymapUtil.Compare_to_clipboard, { desc = '[C]ompare to [C]lipboard' })

-- gitlab
set('n', '<leader>gP', KeymapUtil.Gitlab_pipelines_toggle, { noremap = true, silent = true, desc = '[G]itlab [P]ipeline (current branch)' })
set('n', '<leader>gm', '<cmd>!glab mr view --web<cr>', { noremap = true, silent = true, desc = '[G]itlab open [M]erge request (current branch)' })

set('n', 'gF', '<C-w>F', { noremap = true, silent = true, desc = '[G]oto [F]ile under cursor in new split' })

------ del ------

del('n', '<leader>gb')
del({ 'n', 'x' }, '<leader>gY')
