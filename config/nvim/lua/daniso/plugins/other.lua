return {
  'rgroli/other.nvim',
  config = function()
    require('other-nvim').setup {
      mappings = {
        -- custom mapping
        {
          pattern = 'ts/src/(.*)/(.*).tsx$',
          target = 'ts/tests/%1/%2.test.tsx',
          transformer = 'lowercase',
          context = 'test',
        },
        {
          pattern = 'ts/src/(.*)/(.*).ts$',
          target = 'ts/tests/%1/%2.test.ts',
          transformer = 'lowercase',
          context = 'test',
        },
        {
          pattern = 'ts/src/(.*)/(.*).tsx$',
          target = 'ts/src/%1/%2.less',
          transformer = 'lowercase',
          context = 'less',
        },
        {
          pattern = 'ts/tests/(.*)/(.*).test.tsx$',
          target = 'ts/src/%1/%2.tsx',
          transformer = 'lowercase',
        },
        {
          pattern = 'ts/tests/(.*)/(.*).test.ts$',
          target = 'ts/src/%1/%2.ts',
          transformer = 'lowercase',
        },
        {
          pattern = 'ts/tests/(.*)/(.*).test.tsx$',
          target = 'ts/tests/%1/__snapshots__/%2.test.tsx.snap',
          transformer = 'lowercase',
          context = 'snap',
        },
        {
          pattern = 'ts/tests/(.*)/(.*).test.ts$',
          target = 'ts/tests/%1/__snapshots__/%2.test.ts.snap',
          transformer = 'lowercase',
          context = 'snap',
        },
        {
          pattern = 'ts/src/(.*)/(.*).less$',
          target = 'ts/src/%1/%2.tsx',
          transformer = 'lowercase',
        },
        {
          pattern = '(.*).txt$',
          target = '%1.mjml',
          context = 'mjml-email',
        },
        {
          pattern = '(.*).txt$',
          target = '%1.html',
          context = 'html-email',
        },
        {
          pattern = '(.*).(mjml|html)$',
          target = '%1.txt',
          context = 'txt-email',
        },
      },
      transformers = {
        -- defining a custom transformer
        lowercase = function(inputString)
          return inputString:lower()
        end,
      },
    }
  end,
  keys = function()
    require('which-key').add {
      { 'go', group = '[G]oto [O]ther' },
      { 'gos', group = '[G]oto [O]ther [S]plit' },
      { 'gov', group = '[G]oto [O]ther [V]-split' },
    }
    return {
      { 'goo', ':Other<CR>', desc = '[G]oto [O]ther [o]' },
      { 'goso', ':OtherSplit<CR>', desc = '[G]oto [O]ther [S]plit [o]' },
      { 'govo', ':OtherVSplit<CR>', desc = '[G]oto [O]ther [V]-split [o]' },
      { 'got', ':Other test<CR>', desc = '[G]oto [O]ther [T]est' },
      { 'gost', ':OtherSplit test<CR>', desc = '[G]oto [O]ther [S]plit [T]est' },
      { 'govt', ':OtherVSplit test<CR>', desc = '[G]oto [O]ther [V]-split [T]est' },
      { 'gol', ':Other less<CR>', desc = '[G]oto [O]ther [L]ess' },
      { 'gosl', ':OtherSplit less<CR>', desc = '[G]oto [O]ther [S]plit [L]ess' },
      { 'govl', ':OtherVSplit less<CR>', desc = '[G]oto [O]ther [V]-split [L]ess' },
      { 'gom', ':Other mjml-email<CR>', desc = '[G]oto [O]ther [M]jml-email' },
      { 'gosm', ':OtherSplit mjml-email<CR>', desc = '[G]oto [O]ther [S]plit [M]jml-email' },
      { 'govm', ':OtherVSplit mjml-email<CR>', desc = '[G]oto [O]ther [V]-split [M]jml-email' },
      { 'gox', ':Other txt-email<CR>', desc = '[G]oto [O]ther [T]xt-email' },
      { 'gosx', ':OtherSplit txt-email<CR>', desc = '[G]oto [O]ther [S]plit [T]xt-email' },
      { 'govx', ':OtherVSplit txt-email<CR>', desc = '[G]oto [O]ther [V]-split [T]xt-email' },
      { 'goh', ':Other html-email<CR>', desc = '[G]oto [O]ther [H]tml-email' },
      { 'gosh', ':OtherSplit html-email<CR>', desc = '[G]oto [O]ther [S]plit [H]tml-email' },
      { 'govh', ':OtherVSplit html-email<CR>', desc = '[G]oto [O]ther [V]-split [H]tml-email' },
    }
  end,
}
