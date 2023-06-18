<h1 align="center"> go-heat.nvim 🔥 </h1>

A neovim plugin to show the heatmap of your Go project, for a bird eye view of the test coverage.

## Installation
```lua
-- Packer
use {  'lordvidex/go-heat.nvim',
  requires = { 'akinsho/toggleterm.nvim' },
  config = function() 
    require('go-heat').setup() 
  end
}
```
## Screenshots
### Heat in-Browser
![Browser Shot](https://github.com/lordvidex/go-heat.nvim/assets/49334512/20e6c4e4-ec81-4c6d-a9b0-2a6aa8a38f84)
### Heat in-Neovim
![Terminal Shot](https://github.com/lordvidex/go-heat.nvim/assets/49334512/90d86f1d-98ab-49a5-9fa1-e7416b05e318)
## Default configurations
Below are the default configurations. You can override them by passing a table to the setup function.
```lua
local configs = {
  coverprofile = nil,                        -- default coverage profile (go-heat tries to look in cwd)
  svg_output = '/tmp/go-heat/temp.svg',      -- if not nil, will output the svg to this file
  open_in = 'browser',                      -- 'terminal' | 'browser' (terminal has lower quality than browser)
  browser_type = 'safari'                    -- only peculiar to Darwin; tested options: 'safari' | 'chrome' | 'arc' 
  debug = false,                            -- if true, will print debug messages
  -- any option passed to browser_type must be executable with `open` -a <name> in macos
}
```
## Keymaps
This plugin does not set any keymap and you can set your own keymap to call the `show` function.  
Below is an example of setting a keymap.
```lua
-- show the heatmap
vim.api.nvim_set_keymap('n', '<localleader>gth', '<cmd>lua require("go-heat").show()<cr>', { noremap = true, silent = true })
```

## Requirements
- [go](https://golang.org/doc/install) should be installed
- [go-cover-treemap](https://github.com/nikolaydubina/go-cover-treemap/tree/main) should be installed
- [toggleterm](https://github.com/akinsho/toggleterm) should be installed (if opening in 'terminal') 

## References
- [go cover treemap](https://github.com/nikolaydubina/go-cover-treemap/): A tool to generate treemap visualizations of Go cover profiles

<!-- add my checklist and todo for future releases -->
## Checklist
- [ ] Add convenient plugs and probably keymaps
- [ ] Improve terminal render quality
- [ ] Add more options for go-cover-treemap e.g. package_only, colors, etc
- [ ] Reduce plugin dependencies / add scripts to install dependencies for all platforms
---
Please star🌟 this repository if you found go-heat useful.  
Feel free to open an issue 🔭 or PR ➕ if you have any suggestions or contributions.
