-- File Explorer

return {
  desc = 'Snacks File Explorer',
  recommended = true,
  'folke/snacks.nvim',
  opts = { explorer = {} },
  keys = {
    {
      '<leader>fE',
      function()
        Snacks.explorer { cwd = LazyVim.root() }
      end,
      desc = 'Explorer Snacks (root dir)',
    },
    {
      '<leader>fe',
      function()
        Snacks.explorer { ignored = true, hidden = true, layout = { preset = 'sidebar', preview = true }, watch = true }
      end,
      desc = 'Explorer Snacks (cwd)',
    },
    { '<leader>E', '<leader>fE', desc = 'Explorer Snacks (root dir)', remap = true },
    { '<leader>e', '<leader>fe', desc = 'Explorer Snacks (cwd)', remap = true },
  },
}
