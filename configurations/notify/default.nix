{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.notify ];

  config.vim.config.lua.notify = ''
    require('notify').setup({
      background_color = "#000000",
    })
    vim.notify = require('notify')
  '';
}
