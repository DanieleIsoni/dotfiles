-- LSP

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ruff = {
          mason = false,
        },
        jsonnet_ls = {},
        gitlab_ci_ls = {},
        taplo = {
          formatting = {
            trailing_newline = true,
          },
        },
      },
    },
  },
}
