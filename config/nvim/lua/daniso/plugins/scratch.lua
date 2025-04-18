return {
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
      scratch = {
        -- your scratch configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
    keys = {
      -- stylua: ignore
      { '<leader>;', function() Snacks.scratch({name="todo", ft="markdown"}) end, desc = 'Toggle ToDo Scratch' },
    },
  },
}
