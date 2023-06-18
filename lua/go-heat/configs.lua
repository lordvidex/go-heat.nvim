local M = {}
-- default configs
local configs = {
  coverprofile = nil,                   -- default coverage profile
  svg_output = '/tmp/go-heat/temp.svg', -- if not nil, will output the svg to this file
  open_in = 'browser',
  browser_type = 'safari',              -- 'safari|chrome|firefox|arc'
  debug = true,
}

M.setup = function(cfg)
  local utils = require 'go-heat.utils'
  print('config before')
  utils.print_configs()
  M.configs = vim.tbl_deep_extend('force', configs, cfg or {})
  utils.print_configs()
end

M.configs = configs

return M
