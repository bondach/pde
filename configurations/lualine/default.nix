{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.lualine pkgs.plugins.web-devicons ];

  config.vim.config.lua.lualine = ''
    require('lualine').setup()
  '';
}
