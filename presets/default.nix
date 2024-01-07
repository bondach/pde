let
  base = {
    vim = {
      lsp = {
        enable = false;
        scala = {
          enable = false;
        };
        nix.enable = false;
        clojure.enable = false;
      };
    };
  };

  scala = {
    vim.lsp.enable = true;
    vim.lsp.scala.enable = true;
    vim.lsp.nix.enable = false;
    vim.lsp.clojure.enable = false;
  };

  nix = {
    vim.lsp.enable = true;
    vim.lsp.scala.enable = false;
    vim.lsp.nix.enable = true;
    vim.lsp.clojure.enable = false;
  };

  clojure = {
    vim.lsp.enable = true;
    vim.lsp.scala.enable = false;
    vim.lsp.nix.enable = false;
    vim.lsp.clojure.enable = true;
  };

in {
  base = base;
  scala = scala;
  nix = nix;
  clojure = clojure;
}
