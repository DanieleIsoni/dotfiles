local M = {}

function M.insert_elements(section, elements)
  local opts = require('lualine').get_config()
  table.insert(opts.sections[section], elements)
  require('lualine').setup(opts)
end

return M
