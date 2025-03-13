return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope-ui-select.nvim',
      config = function()
        LazyVim.on_load('telescope.nvim', function()
          pcall(require('telescope').load_extension 'ui-select')
        end)
      end,
    },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      config = function()
        LazyVim.on_load('telescope.nvim', function()
          pcall(require('telescope').load_extension 'live_grep_args')
          local builtin = require 'telescope.builtin'
          -- stylua: ignore start
          vim.keymap.set('n', '<leader>/', function ()
            require('telescope').extensions.live_grep_args.live_grep_args({additional_args={"--hidden", "-g!.test_durations", "-g!.git/**"}})
          end, { desc = '[/] Search by Grep'})
          vim.keymap.set('n', '<leader>sw', require('telescope-live-grep-args.shortcuts').grep_word_under_cursor, { desc = '[G]rep word under cursor' })
          vim.keymap.set('v', '<leader>sw', require('telescope-live-grep-args.shortcuts').grep_visual_selection, { desc = '[G]rep visual selection' })
          -- stylua: ignore end
          vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
          end, { desc = '[S]earch [/] in Open Files' })
        end)
      end,
    },
    {
      'sopa0/telescope-makefile',
      dependencies = {
        'akinsho/nvim-toggleterm.lua',
      },
      lazy = false,
      config = function()
        LazyVim.on_load('telescope.nvim', function()
          pcall(require('telescope').load_extension 'make')
          vim.keymap.set('n', '<leader>sm', '<cmd>Telescope make<cr>', { desc = '[S]earch [M]akefile' })
        end)
      end,
    },
  },
  opts = {
    defaults = {
      layout_strategy = 'vertical',
      layout_config = {
        vertical = { width = 0.8, height = 0.95, prompt_position = 'top', preview_height = 0.7 },
        horizontal = { width = 0.9 },
      },
      sorting_strategy = 'ascending',
      winblend = 0,
    },
    pickers = {
      find_files = {
        find_command = {
          'rg',
          '--files',
          '--hidden',
          '--glob',
          '!**/.git/*',
          '--glob',
          '!**/node_modules/*',
          '--glob',
          '!**/.mypy_cache/*',
          '--glob',
          '!**/__pycache__/*',
        },
        no_ignore = true,
        hidden = true,
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  },
  keys = {
    { '<leader>sr', '<cmd>Telescope resume<cr>', desc = 'Resume' },
    { '<leader>,', false },
    { '<leader>sb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', desc = 'Switch Buffer' },
    { '<leader>sB', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
    { '<leader><space>', LazyVim.pick('files', { root = false }), desc = 'Find Files (Root Dir)' },
  },
}
