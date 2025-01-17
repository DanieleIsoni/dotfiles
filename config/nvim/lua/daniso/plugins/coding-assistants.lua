return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      provider = 'openai',
      auto_suggestions_provider = 'openai_autosuggestions',
      openai = {
        endpoint = 'http://localhost:12345/api',
        model = os.getenv 'CLAUDE_BEDROCK_ARN',
        temperature = 0,
        max_tokens = 4096,
      },
      vendors = {
        ['openai_autosuggestions'] = {
          __inherited_from = 'openai',
          endpoint = 'http://localhost:12345/api',
          model = 'gpt-4o-mini',
          allow_insecure = false, -- Allow insecure server connections
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 4096,
        },
      },
      behaviour = {
        auto_suggestions = false,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  -- {
  --   'milanglacier/minuet-ai.nvim',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' },
  --     { 'hrsh7th/nvim-cmp' },
  --   },
  --   config = function()
  --     require('minuet').setup {
  --       -- Your configuration options here
  --       provider = 'openai_compatible',
  --       provider_options = {
  --         openai_compatible = {
  --           api_key = 'OPENAI_API_KEY',
  --           end_point = 'http://localhost:12345/api/chat/completions',
  --           model = 'gpt-4o-mini',
  --           name = 'bedrock',
  --           optional = {
  --             max_tokens = 4096,
  --             top_p = 0.9,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
}
