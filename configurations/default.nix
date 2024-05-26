{ pkgs, lib ? pkgs.lib, ... }:

with lib;
with builtins;

{
  options.vim.config.lua = mkOption {
    type = types.attrs;
    description = "Neovim's lua configs";
  };
  options.vim.plugins = mkOption {
    description = "Neovim's plugins";
    type = with types; listOf (nullOr package);
  };

  imports = [
    ./basic
    ./telescope
    ./neotree
    ./gitsigns
    ./bqf
    ./themes
    ./lualine
    ./ufo
    ./statuscol
    ./treesitter
    ./notify
    ./paredit
    ./lsp
    ./cmp
    ./whichkey
  ];
}

