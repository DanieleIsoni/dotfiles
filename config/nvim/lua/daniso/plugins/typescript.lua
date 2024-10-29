-- Typescript

return {
  {
    'yioneko/nvim-vtsls',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
  },
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = { "haydenmeade/neotest-jest" },
  --   opts = function(_, opts)
  --     table.insert(
  --       opts.adapters,
  --       require("neotest-jest")({
  --         jestCommand = "npx jest",
  --         cwd = function()
  --           return vim.fn.getcwd()
  --         end,
  --       })
  --     )
  --   end,
  -- },
}
