local utils = require 'go-heat.utils'

local M = {}

local or_file = function(val)
  if val then
    return val
  end
  local curr_dir = vim.fn.getcwd()
  local opts = { 'cover.out', 'coverage.out', 'cover.cov', 'coverage.cov' }
  for _, opt in ipairs(opts) do
    local file = curr_dir .. '/' .. opt
    if utils.file_exists(file) then
      return file
    end
  end
end

M.generate_svg = function(cfg)
  local svg_file = cfg.svg_output
  -- svg file must end in .svg
  if not svg_file:match('%.svg$') then
    svg_file = svg_file .. '.svg'
  end
  if not utils.file_exists(svg_file) then
    utils.create_file(svg_file)
  end
  local cov_file = or_file(cfg.coverage_file)
  if not cov_file then
    print('no coverage file found')
    return nil
  end
  local cmd = string.format('go-cover-treemap -coverprofile=%s > %s', cov_file, svg_file)
  print(cmd)
  local res = os.execute(cmd)
  if not res then
    print('failed to run go-cover-treemap')
    return nil
  end
  return svg_file
end

return M
