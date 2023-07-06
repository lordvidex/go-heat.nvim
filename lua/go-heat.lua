local display = require 'go-heat.display'
local cover = require 'go-heat.cover'

local M = {}
M.show = function()
  -- parse the coverage file and generate an svg
  local conf = require 'go-heat.configs'.configs
  local svg_file = cover.generate_svg(conf)
  if not svg_file then
    return
  end
  -- display svg with display
  display.show(svg_file)
end

-- M.close = display.close (cmd is killed once browser is opened)

M.print_configs = require 'go-heat.utils'.print_configs

M.setup = function(cfg)
  require 'go-heat.configs'.setup(cfg)
  require 'go-heat.utils'.setup()
  display.init()
end
return M
