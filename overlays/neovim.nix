{inputs, config, ...}:

f: p:
let
  neovim = inputs.neovim.packages.${f.system}.neovim;
  neovimConfigurations = p.lib.evalModules {
    modules = [ 
                { imports = [ ../configurations ]; } 
                config
              ];
    specialArgs = { pkgs = p; };
  };
  ncfg = neovimConfigurations.config.vim.config.lua;
in {
  neovim = p.wrapNeovim neovim {
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        lua << EOF
        ${ncfg.basic}
        ${ncfg.telescope}
        ${ncfg.neotree}
        ${ncfg.gitsigns}
        ${ncfg.lualine}
        ${ncfg.bqf}
        ${ncfg.themes}
        ${ncfg.ufo}
        ${ncfg.statuscol}
        ${ncfg.treesitter}
        ${ncfg.notify}
        ${ncfg.lsp}
        ${ncfg.cmp}
        ${ncfg.paredit}
        ${ncfg.whichkey}
        EOF
      '';
      packages.myVimPackage = {
        start = p.lib.lists.unique(neovimConfigurations.config.vim.plugins);
      };
    };
  };
}
