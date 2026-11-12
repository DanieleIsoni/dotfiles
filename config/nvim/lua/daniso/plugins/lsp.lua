-- LSP

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        sourcekit = {
          mason = false,
          cmd = { 'xcrun', 'sourcekit-lsp' },
          filetypes = { 'swift' },
        },
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
