-- Test

require('which-key').add { { '<leader>tc', group = '[T]est [C]overage' } }

return {
  {
    'nvim-neotest/neotest',
    keys = {
      { '<leader>tt', false },
      -- stylua: ignore
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    },
  },
  {
    'andythigpen/nvim-coverage',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function()
      return {
        { '<leader>tcc', '<cmd>Coverage<cr>', desc = '[T]est Load and Show [C]overage [c]' },
        { '<leader>tch', '<cmd>CoverageHide<cr>', desc = '[T]est [C]overage [H]ide' },
      }
    end,
    config = function()
      require('coverage').setup()
    end,
  },
}
