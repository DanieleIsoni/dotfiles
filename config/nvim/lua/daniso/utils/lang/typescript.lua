local M = {}

function M.get_vtsls_config()
  return {
    settings = {
      typescript = {
        inlayHints = {
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
        suggest = {
          includeCompletionsForModuleExports = false,
        },
      },
      javascript = {
        inlayHints = {
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
        suggest = {
          includeCompletionsForModuleExports = false,
        },
      },
    },
    on_attach = function(_, bufnr)
      vim.lsp.inlay_hint.enable(true, { bufnr })

      vim.keymap.set('n', '<leader>ci', '<cmd>VtsExec add_missing_imports<CR>', { buffer = bufnr, desc = 'LSP: [C]ode [i]mport all' })
      vim.keymap.set('n', '<leader>co', '<cmd>VtsExec organize_imports<CR>', { buffer = bufnr, desc = 'LSP: [C]ode [o]rganize imports' })
      vim.keymap.set('n', '<leader>cs', '<cmd>VtsExec source_actions<CR>', { buffer = bufnr, desc = 'LSP: [C]ode [s]ource actions' })
      vim.keymap.set('n', '<leader>cu', '<cmd>VtsExec remove_unused<CR>', { buffer = bufnr, desc = 'LSP: [C]ode [r]emove unused' })
      vim.keymap.set('n', '<leader>cF', '<cmd>VtsExec file_references<CR>', { buffer = bufnr, desc = 'LSP: [C] [F]ile references' })
    end,
  }
end

return M
