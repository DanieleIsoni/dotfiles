-- Statusline

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'dashboard' },
          winbar = {},
        },
        ignore_focus = { 'neo-tree' },
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
          },
          'diagnostics',
        },
        lualine_c = {
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { 'filename', path = 1 },
        },
        lualine_x = {},
        lualine_y = { 'encoding', 'fileformat' },
        lualine_z = { 'searchcount', 'location' },
      },
      inactive_sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'branch', 'diff' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
      theme = 'tokyonight',
    },
  },
}
