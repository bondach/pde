{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.which-key ];

  config.vim.luaConfigRC = ''
    vim.o.timeout    = true
    vim.o.timeoutlen = 500
    
    local which_key = require('which-key')
    which_key.setup({})
    which_key.register({
      ["<leader>f"] = { name = "find" },
    })
  '';
}
