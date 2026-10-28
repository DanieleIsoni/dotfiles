vim.g.autoformat = false
local is_linux = vim.uv.os_uname().sysname == "Linux"
local has_display = vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY
if is_linux and not has_display and (vim.env.REX_SESSION or vim.env.SSH_TTY) then
  -- Important: don't redirect normal puts to the system clipboard
  vim.g.clipboard = ""

  local osc52_copy = require("vim.ui.clipboard.osc52").copy("+")

  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("osc52_yank", { clear = true }),
    callback = function()
      if vim.v.event.operator == "y" then
        osc52_copy(vim.v.event.regcontents, vim.v.event.regtype)
      end
    end,
  })
end

-- Make line numbers default
vim.opt.number = true
-- Make line numbers relative, to help with jumping.
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.g.python3_host_prog = '~/.virtualenvs/nvim-venv/bin/python'

vim.g.lazyvim_picker = 'telescope'
