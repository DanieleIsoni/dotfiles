local set = vim.keymap.set
local wk = require 'which-key'

-- neotest

wk.add {
  { '<leader>tb', group = '[T]est with create-d[b]' },
}

---- create-db
set('n', '<leader>tbr', function()
  require('neotest').run.run {
    suite = false,
    extra_args = { '--create-db' },
  }
end, { desc = '[T]est with create-d[b] [R]un Nearest' })

set('n', '<leader>tbf', function()
  require('neotest').run.run {
    vim.fn.expand '%',
    suite = false,
    extra_args = { '--create-db' },
  }
end, { desc = '[T]est Run with create-d[b] [F]ile' })

---- coverage
set('n', '<leader>tcr', function()
  require('neotest').run.run {
    suite = false,
    extra_args = { '-p', 'pytest_cov', '--cov', '--cov-append' },
  }
end, { desc = '[T]est with [C]ov [R]un Nearest' })

set('n', '<leader>tcf', function()
  require('neotest').run.run {
    vim.fn.expand '%',
    suite = false,
    extra_args = { '-p', 'pytest_cov', '--cov', '--cov-append' },
  }
end, { desc = '[T]est with [C]ov Run [F]ile' })

set('n', '<leader>tcT', function()
  require('neotest').run.run {
    vim.uv.cwd(),
    suite = false,
    extra_args = { '-p', 'pytest_cov', '--cov' },
  }
end, { desc = '[T]est with [C]ov Run All [T]ests' })

-- debug
set('n', '<leader>dPt', function() require('dap-python').test_method() end, { desc = '[D]ebug: [P]ython Me[t]hod' })
set('n', '<leader>dPc', function() require('dap-python').test_class() end, { desc = '[D]ebug: [P]ython [C]lass' })
