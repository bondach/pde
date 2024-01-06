{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.lualine pkgs.plugins.web-devicons ];

  config.vim.luaConfigRC = ''
    require('lualine').setup()
  '';
}
