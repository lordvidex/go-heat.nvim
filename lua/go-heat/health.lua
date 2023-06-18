local utils = require 'go-heat.utils'
local M = {}
M.check = function()
  -- check for external dependencies
  vim.health.start('go-heat dependencies')
  local deps = utils.check_deps()
  local available = 0
  for _, v in ipairs(deps) do
    if v[2] then
      available = available + 1
      vim.health.ok(v[1] .. ' found')
    else
      vim.health.error(v[1] .. ' not found')
    end
  end

  -- check for ToggleTerm
  vim.health.start('ToggleTerm')
  local ok, _ = pcall(require 'toggleterm')
  if ok then
    vim.health.ok('ToggleTerm found')
  else
    vim.health.error('ToggleTerm not found')
  end
end
return M
