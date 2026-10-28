return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'caddy',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters = {
        caddy = {
          command = 'caddy',
          args = { 'fmt', '-' },
          stdin = true,
        },
      },
      formatters_by_ft = {
        caddy = {'caddy'}
      },
    },
  },
}
