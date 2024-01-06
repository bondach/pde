{ pkgs, lib ? pkgs.lib, config, ... }:

with lib;

let
  cfg = config.vim.lsp;
  writeIf = cond: msg: if cond then msg else "";
in {
  options.vim.lsp.nix.enable = mkEnableOption "Nix LSP (nixd)";

  config = mkIf (cfg.enable && cfg.nix.enable) {
    vim.plugins = [ pkgs.plugins.lspconfig ];
    vim.luaConfigRC = ''
      require('lspconfig').nixd.setup {
        cmd = { "${pkgs.nixd}/bin/nixd" },
      }
    '';
  };
}
