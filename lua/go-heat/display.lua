local ok_term, term = pcall(require, 'toggleterm.terminal')
if not ok_term then
  print('toggleterm not installed')
  return
end
local heat = nil
local Terminal = term.Terminal
local enabled = false -- set to false if initialized properly

local M = {}
M.show = function(file)
  if not enabled then
    print('cannot display heatmap, run :checkhealth go-heat for more info')
    return
  end
  if not file then
    -- debug print
    print('no file provided')
    return
  end
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

local heat_group = vim.api.nvim_create_augroup('GO_HEATMAP_POPUP', { clear = true })

M.init = function()
  enabled = true -- enable display
end
return M
