local configs = require 'go-heat.configs'
local utils = require 'go-heat.utils'
local display = require 'go-heat.display'
local cover = require 'go-heat.cover'

local M = {}
M.show = function()
  -- parse the coverage file and generate an svg
  local conf = configs.configs
  local svg_file = cover.generate_svg(conf)
  if not svg_file then
    return
  end
  -- display svg with display
  display.show(svg_file)
end
M.setup = function(cfg)
  utils.setup()
  configs.setup(cfg)
  display.init()
end
return M
