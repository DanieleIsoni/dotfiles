local ft_map = { py = 'python', ts = 'typescript', js = 'javascript', rb = 'ruby', yml = 'yaml', mk = 'make' }

--- Strip Jinja template tags from a filename and resolve the inner filetype.
--- e.g. `{% if cond %}services.yaml{% endif %}.jinja` → `yaml.jinja`
local function jinja_ft(path)
  local name = vim.fn.fnamemodify(path, ':t')
  local clean = name:gsub('{%%.-%%}', '')
  if clean:match '[Mm]akefile' then
    return 'make.jinja'
  end
  local ext = clean:match '%.(%a+)%.jinja$'
  if ext then
    return (ft_map[ext] or ext) .. '.jinja'
  end
  return 'jinja'
end

vim.filetype.add {
  pattern = {
    ['.*%.(%a+)%.jinja'] = {
      function(_, _, ext)
        local inner = ft_map[ext] or ext
        return inner .. '.jinja'
      end,
      { priority = 10 },
    },
    ['.*[Mm]akefile%.jinja'] = { 'make.jinja', { priority = 10 } },
    ['.*{%%.*%%}.*%.jinja'] = {
      function(path)
        return jinja_ft(path)
      end,
      { priority = 20 },
    },
  },
}
