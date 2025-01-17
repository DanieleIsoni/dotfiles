-- Colorscheme

return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
  },
  { 'morhetz/gruvbox', priority = 1000 },
  { 'scottmckendry/cyberdream.nvim', priority = 1000 },
  {
    'navarasu/onedark.nvim',
    opts = {
      style = 'warmer',
    },
    priority = 1000,
  },
  { 'projekt0n/github-nvim-theme', name = 'github-theme', priority = 1000 },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
