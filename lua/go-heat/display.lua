local utils = require 'go-heat.utils'
local ok_term, term = pcall(require, 'toggleterm.terminal')
if not ok_term then
  utils.print('toggleterm not installed')
  return
end


local heat = nil
local job_id = nil
local Terminal = term.Terminal

local function open_in_browser(file)
  local command = ''
  if vim.fn.has('mac') == 1 then
    local cmd = require 'go-heat.configs'.configs.browser_type
    if cmd == 'chrome' then
      cmd = 'Google Chrome'
    end
    utils.print(cmd .. file .. 'command running')
    command = string.format("open -a '%s' %s", cmd, file)
  elseif vim.fn.has('unix') == 1 then
    command = string.format("xdg-open %s", file)
  else
    utils.print('open_in_browser: unsupported OS')
    return
  end
  -- run the command
  job_id = vim.fn.jobstart(command, {
    on_exit = function(_, code)
      if code ~= 0 then
        utils.print('open_in_browser: failed to open file')
      else
        utils.print('SVG file opened in browser')
      end
    end
  })
end
local function show_in_terminal(file)
  heat = Terminal:new({
    cmd = string.format('chafa --animate=off --center=on --clear %s', file),
    hidden = true,
    direction = 'float',
    close_on_exit = false,
    on_open = function(t)
      -- vim.api.nvim_create_autocmd('GO_HEAT_KEYBINDINGS', {
      --   buffer = t.bufnr,
      --   group = heat_group,
      --   callback = function()
      --     vim.api.nvim_buf_set_keymap(t.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      --   end
      -- })
    end,
  })
  heat:open()
end

local M = {}
M.show = function(file)
  if not file then
    -- debug print
    utils.print('no file provided')
    return
  end
  local configs = require 'go-heat.configs'.configs
  if configs.open_in == 'browser' then
    open_in_browser(file)
  elseif configs.open_in == 'terminal' then
    show_in_terminal(file)
  else
    utils.print('invalid option ' .. '"' .. configs.open_in .. '"')
  end
end

local close = function()
  if heat then
    heat:close()
    heat = nil
  end
  if job_id then
    vim.fn.jobstop(job_id)
    job_id = nil
  end
end


local heat_group = vim.api.nvim_create_augroup('GO_HEATMAP_POPUP', { clear = true })

M.init = function()
  --TODO: add keybindings
end
return M
