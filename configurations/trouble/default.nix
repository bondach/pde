{ pkgs, config, ... }:


{
  config.vim.plugins =
    if config.vim.lsp.enable then
      [ pkgs.plugins.trouble pkgs.plugins.web-devicons ]
    else [];

}
