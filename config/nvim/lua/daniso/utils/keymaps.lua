local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- compare_to_clipboard
function M.Compare_to_clipboard()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format(
    [[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]],
    ftype,
    ftype
  ))
end

-- lazygit
local lazygit = Terminal:new({
  cmd = "lazygit",
  count = 5,
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
})

function M.Lazygit_toggle()
  lazygit:toggle()
end

-- gitlab
local gitlab_pipelines = Terminal:new({
  cmd = "glab ci status -lc",
  count = 6,
  dir = "git_dir",
  close_on_exit = false,
})

function M.Gitlab_pipelines_toggle()
  gitlab_pipelines:toggle(70, "vertical")
end

return M
