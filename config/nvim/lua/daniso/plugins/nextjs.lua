return {
  'mfussenegger/nvim-dap',
  opts = function()
    local dap = require 'dap'

    local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

    for _, language in ipairs(js_filetypes) do
      dap.configurations[language] = vim.list_extend(dap.configurations[language], {
        {
          name = 'Next.js: debug server-side',
          type = 'pwa-node',
          request = 'attach',
          port = 9231,
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
          cwd = '${workspaceFolder}',
        },
      })
    end
  end,
}
