local M = {}
-- default configs
local configs = {
  coverprofile = nil,                   -- default coverage profile
  svg_output = '/tmp/go-heat/temp.svg', -- if not nil, will output the svg to this file
  open_in = 'browser',
  browser_type = 'safari',              -- 'safari|chrome|firefox|arc'
  debug = false,
}

M.setup = function(cfg)
  M.configs = vim.tbl_deep_extend('force', configs, cfg or {})
end

M.configs = configs

return M
