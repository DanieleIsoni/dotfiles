-- debug.lua

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    -- virtual text for the debugger
    { 'theHamsta/nvim-dap-virtual-text' },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    require('daniso.utils.lang.python').dap_python_package,
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<leader>dc', dap.continue, desc = '[D]ebug: Start/[C]ontinue' },
      { '<leader>di', dap.step_into, desc = '[D]ebug: Step [I]nto' },
      { '<leader>dn', dap.step_over, desc = '[D]ebug: Step Over - [N]ext' },
      { '<leader>do', dap.step_out, desc = '[D]ebug: Step [O]ut' },
      { '<leader>dj', dap.down, desc = '[D]ebug: [j] Down' },
      { '<leader>dk', dap.up, desc = '[D]ebug: [k] Up' },
      { '<leader>db', dap.toggle_breakpoint, desc = '[D]ebug: Toggle [B]reakpoint' },
      { '<leader>dt', dap.terminate, desc = '[D]ebug: [T]erminate' },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[D]ebug: Set [B]reakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<leader>du', dapui.toggle, desc = '[D]ebug: [U]I See last session result.' },
      { '<leader>de', dapui.eval, desc = '[D]ebug: [E]val', mode = { 'n', 'v' } },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        'delve',
        'python',
      },
    }

    -- change icons
    local dap_icons = {
      Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
      Breakpoint = { ' ' },
      BreakpointCondition = { ' ' },
      BreakpointRejected = { ' ', 'DiagnosticError' },
      LogPoint = { '.>' },
    }
    for name, sign in pairs(dap_icons) do
      vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
    end

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-go').setup {
      delve = {},
    }
    require('daniso.utils.lang.python').setup_dap_python()
  end,
}
