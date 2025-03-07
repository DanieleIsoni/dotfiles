-- Package Info

require('which-key').add {
  { '<leader>p', group = '[P]ackage info', icon = LazyVim.config.icons.kinds.Package },
  { '<leader>pp', group = '[P]ackage info: [P]y', icon = '' },
  { '<leader>pt', group = '[P]ackage info: [T]s', icon = '' },
}
return {
  {
    'DanieleIsoni/py-package-info.nvim',
    -- dir = "~/dev/personal/py-package-info.nvim/",
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('py-package-info').setup()

      require('which-key').add {
        { '<leader>pp', group = '[P]ackage info: [P]y' },
      }

      -- stylua: ignore start
      vim.keymap.set('n', '<leader>ppt', ":lua require('py-package-info').toggle({ force = true })<CR>", { desc = '[P]ackage info: [P]y [T]oggle Info' })
      vim.keymap.set('n', '<leader>ppi', ":lua require('py-package-info').install()<CR>", { desc = '[P]ackage info: [P]y [I]nstall package' })
      vim.keymap.set('n', '<leader>ppu', ":lua require('py-package-info').update()<CR>", { desc = '[P]ackage info: [P]y [U]pdate package' })
      vim.keymap.set('n', '<leader>ppd', ":lua require('py-package-info').delete()<CR>", { desc = '[P]ackage info: [P]y [D]elete package' })
      -- stylua: ignore end
    end,
  },
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('package-info').setup()

      -- stylua: ignore start
      vim.keymap.set('n', '<leader>ptt', ":lua require('package-info').toggle({ force = true })<CR>", { desc = '[P]ackage info: [T]s [T]oggle Info' })
      vim.keymap.set('n', '<leader>ptu', ":lua require('package-info').update()<CR>", { desc = '[P]ackage info: [T]s [U]pdate package' })
      vim.keymap.set('n', '<leader>ptc', ":lua require('package-info').change_version()<CR>", { desc = '[P]ackage info: [T]s [C]hange version' })
      vim.keymap.set('n', '<leader>pti', ":lua require('package-info').install()<CR>", { desc = '[P]ackage info: [T]s [I]nstall package' })
      vim.keymap.set('n', '<leader>ptd', ":lua require('package-info').delete()<CR>", { desc = '[P]ackage info: [T]s [D]elete package' })
      -- stylua: ignore end
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 3, function()
        return require('py-package-info').get_status()
      end)
      table.insert(opts.sections.lualine_x, 4, function()
        return require('package-info').get_status()
      end)
    end,
  },
}
