local M = {}

local printt = function(...)
  local configs = require 'go-heat.configs'.configs
  if configs.debug then
    print(...)
  end
end

M.print = printt

M.check_deps = function()
  local dependencies = {
    { 'go',               false },
    { 'chafa',            false },
    { 'go-cover-treemap', false },
  }
  for _, v in ipairs(dependencies) do
    if vim.fn.executable(v[1]) then
      v[2] = true
    end
  end
  return dependencies
end

local auto_install_gct = function()
  local cmd = 'go install github.com/nikolaydubina/go-cover-treemap@latest'
  local res = os.execute(cmd)
  if res == 0 then
    vim.api.nvim_out_write('go-cover-treemap auto-installed\n')
  else
    vim.api.nvim_err_writeln('Failed to auto-install go-cover-treemap')
  end
end

local auto_install_chafa = function()
  local platform = vim.loop.os_uname().sysname
  local cmds = {
    ['Linux'] = 'apt install chafa',
    ['Darwin'] = 'brew install chafa'
  }
  if cmds[platform] then
    local res = os.execute(cmds[platform])
    if res == 0 then
      vim.api.nvim_out_write('chafa auto-installed\n')
      return
    end
  end
  vim.api.nvim_err_writeln('Failed to auto-install chafa: please install manually at ' ..
    'https://hpjansson.org/chafa/download/')
end

local try_install_dep = function(name)
  if name == 'chafa' then
    auto_install_chafa()
  elseif name == 'go-cover-treemap' then
    auto_install_gct()
  end
end

M.install_deps = function()
  local dependencies = M.check_deps()
  for _, v in ipairs(dependencies) do
    if not v[2] then
      try_install_dep(v[1])
    end
  end
end

M.file_exists = function(file)
  local _, err = vim.loop.fs_stat(file)
  return err == nil
end

local created_dirs = {}
M.create_file = function(path)
  local dir = vim.fn.expand(vim.fn.fnamemodify(path, ':h'))
  if not created_dirs[dir] then
    pcall(vim.loop.fs_rmdir, dir) -- ignore errors
    pcall(vim.loop.fs_mkdir, dir, 755, function(err, ok)
      if err then
        -- TODO: the err could be that the folder already exists
        printt('create directory error:' .. err)
        return
      end
      if ok then
        printt('directory created')
      else
        printt('failed to create directory')
      end
    end)
    created_dirs[dir] = true
  end
  -- create the file
  local file = vim.loop.fs_open(path, 'w', 664)
  if not file then
    return
  end
  -- close the file
  vim.loop.fs_close(file)
end

local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

M.print_configs = function()
  local configs = require 'go-heat.configs'.configs
  print(dump(configs))
end




local setup = function()
  M.install_deps()
end

M.setup = setup
return M
