{inputs, system, config, ...}:

f: p:
let
  neovim = inputs.neovim-nightly-overlay.packages.${system}.neovim;
  neovimConfigurations = p.lib.evalModules {
    modules = [ 
                { imports = [ ../configurations ]; } 
                config
              ];
    specialArgs = { pkgs = p; };
  };
in {
  neovim = p.wrapNeovim neovim {
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        lua << EOF
        ${neovimConfigurations.config.vim.luaConfigRC}
        EOF
      '';
      packages.myVimPackage = {
        start = p.lib.lists.unique(neovimConfigurations.config.vim.plugins);
      };
    };
  };
}
