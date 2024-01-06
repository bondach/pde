{ pkgs, lib ? pkgs.lib, ... }:

with lib;
with builtins;

{
  options.vim.luaConfigRC = mkOption {
    type = types.lines;
    description = "Neovim's lua config";
  };
  options.vim.plugins = mkOption {
    description = "Neovim's plugins";
    type = with types; listOf (nullOr package);
  };
}

