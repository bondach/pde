{ pkgs, config, ... }:


let
  writeIf = cond: msg: if cond then msg else "";
in
{
  config.vim.plugins = [ pkgs.plugins.telescope pkgs.plugins.plenary pkgs.plugins.telescope-live-grep-args ];

  config.vim.config.lua.telescope = ''
    ${builtins.readFile ./config.lua}
    telescope_setup("${pkgs.ripgrep}/bin/rg", "${pkgs.fd}/bin/fd")
    ${writeIf config.vim.lsp.enable (builtins.readFile ./lsp.lua)}
  '';
}
