local M = {}
-- default configs
local configs = {
  coverprofile = nil,                   -- default coverage profile
  svg_output = '/tmp/go-heat/temp.svg', -- if not nil, will output the svg to this file
}

M.setup = function(cfg)
  configs = vim.tbl_deep_extend('force', configs, cfg or {})
end

M.configs = configs

return M
