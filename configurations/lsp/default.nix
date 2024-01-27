{ pkgs, lib ? pkgs.lib, config, ... }:

with lib;

let
  cfg = config.vim.lsp;
  writeIf = cond: msg: if cond then msg else "";
  addIf = cond: pkgs: if cond then pkgs else [];
in {

  options.vim.lsp = {
    enable = mkEnableOption "Lsp support";
    scala.enable = mkEnableOption "Scala LSP (Metals)";
    lua.enable = mkEnableOption "Lua LSP (sumneko-lua-language-server)";
    nix.enable = mkEnableOption "Nix LSP (nixd)";
    clojure.enable = mkEnableOption "Clojure LSP (clojure-lsp)";
  };

  
  config.vim.config.lua.lsp = writeIf cfg.enable ''
    ${builtins.readFile ./common.lua}
    
    ${writeIf cfg.scala.enable ''
      ${builtins.readFile ./scala.lua}
      metals_setup("${pkgs.jdk}", "${pkgs.metals}/bin/metals")
      ''
    }

    ${writeIf cfg.clojure.enable ''
      ${builtins.readFile ./clojure.lua}
      clojure_setup("${pkgs.clojure-lsp}/bin/clojure-lsp")
      ''
    }

    ${writeIf cfg.lua.enable ''
      ${builtins.readFile ./lua.lua}
      lua_setup("${pkgs.sumneko-lua-language-server}/bin/lua-language-server")
      ''
    }

    ${writeIf cfg.nix.enable ''
      ${builtins.readFile ./nix.lua}
      nix_setup("${pkgs.nixd}/bin/nixd")
      ''
    }
  '';

  config.vim.plugins = if cfg.enable then
    (addIf cfg.scala.enable [ pkgs.plugins.metals pkgs.plugins.dap ]) ++
    (addIf cfg.clojure.enable [ pkgs.plugins.conjure ]) ++
    (addIf (cfg.clojure.enable ||
            cfg.nix.enable ||
            cfg.lua.enable) [ pkgs.plugins.lspconfig ])
  else [];
}
