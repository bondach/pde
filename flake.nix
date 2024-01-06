{
  description = "My pde flake";

  outputs = inputs@{ nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem(system:
    let
      pkgs = target:
        let
          presets = import ./presets;
          overlays = import ./overlays {
            inherit inputs system target;
            config = presets.${target};
          };
        in import nixpkgs { inherit system overlays; };

    in {
      packages = {
        default = (pkgs "base").pde;
        scala   = (pkgs "scala").pde;
        nix     = (pkgs "nix").pde;
      };
    }
  );

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixd.url = "github:nix-community/nixd";

    # Neovim's plugins
    # Prefix 'np-' expands to 'neovim plugin'
    #============= Basic plugins section =============
    np-telescope = {
      url = "github:nvim-telescope/telescope.nvim?ref=0.1.5";
      flake = false;
    };
    np-plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    np-neo-tree = {
      url = "github:nvim-neo-tree/neo-tree.nvim?ref=v3.x";
      flake = false;
    };
    np-nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    np-which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    np-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    np-lualine = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    np-gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    np-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    np-promise-async = {
      url   = "github:kevinhwang91/promise-async";
      flake = false;
    };
    np-ufo = {
      url = "github:kevinhwang91/nvim-ufo";
      flake = false;
    };
    np-statuscol = {
      url = "github:luukvbaal/statuscol.nvim";
      flake = false;
    };
    np-notify = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };
    np-metals = {
      url = "github:scalameta/nvim-metals";
      flake = false;
    };
    np-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    np-cmp-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    np-cmp-vsnip = {
      url = "github:hrsh7th/cmp-vsnip";
      flake = false;
    };
    np-vim-vsnip = {
      url = "github:hrsh7th/vim-vsnip";
      flake = false;
    };
    np-nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    np-cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    np-cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    np-cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    np-cmp-lsp-signature-help = {
      url = "github:hrsh7th/cmp-nvim-lsp-signature-help";
      flake = false;
    };
    np-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };


    #------------- Themes section --------------------
    np-kanagawa = {
      url = "github:rebelot/kanagawa.nvim";
      flake = false;
    };
    #-------------------------------------------------

    #=========== Treesitter grammars =================
    ts-g-scala = {
      url = "github:tree-sitter/tree-sitter-scala";
      flake = false;
    };

    ts-g-bash = {
      url = "github:tree-sitter/tree-sitter-bash";
      flake = false;
    };

    ts-g-vimdoc = {
      url = "github:neovim/tree-sitter-vimdoc";
      flake = false;
    };

    ts-g-sql = {
      url = "github:derekstride/tree-sitter-sql?ref=gh-pages";
      flake = false;
    };

    ts-g-java = {
      url = "github:tree-sitter/tree-sitter-java";
      flake = false;
    };

    ts-g-plantuml = {
      url = "github:lyndsysimon/tree-sitter-plantuml";
      flake = false;
    };
    ts-g-rust = {
      url = "github:tree-sitter/tree-sitter-rust";
      flake = false;
    };
    ts-g-zig = {
      url = "github:maxxnino/tree-sitter-zig";
      flake = false;
    };
    ts-g-clojure = {
      url = "github:sogaiu/tree-sitter-clojure";
      flake = false;
    };
    ts-g-hocon = {
      url = "github:antosha417/tree-sitter-hocon";
      flake = false;
    };
    ts-g-proto = {
      url = "github:treywood/tree-sitter-proto";
      flake = false;
    };
    ts-g-fish = {
      url = "github:ram02z/tree-sitter-fish";
      flake = false;
    };
    ts-g-vim = {
      url = "github:neovim/tree-sitter-vim";
      flake = false;
    };
    ts-g-toml = {
      url = "github:ikatyang/tree-sitter-toml";
      flake = false;
    };
    ts-g-nix = {
      url = "github:nix-community/tree-sitter-nix";
      flake = false;
    };
    ts-g-json = {
      url = "github:tree-sitter/tree-sitter-json";
      flake = false;
    };
    ts-g-http = {
      url = "github:rest-nvim/tree-sitter-http";
      flake = false;
    };
    ts-g-gitignore = {
      url = "github:shunsambongi/tree-sitter-gitignore";
      flake = false;
    };
   # TODO: errors in checkhealth
   # ts-g-gitrebase = {
   #   url = "github:the-mikedavis/tree-sitter-git-rebase";
   #   flake = false;
   # };
   # ts-g-gitconfig = {
   #   url = "github:the-mikedavis/tree-sitter-git-config";
   #   flake = false;
   # };
    ts-g-gitcommit = {
      url = "github:gbprod/tree-sitter-gitcommit";
      flake = false;
    };
    ts-g-diff = {
      url = "github:the-mikedavis/tree-sitter-diff";
      flake = false;
    };
    #=================================================

  };
}