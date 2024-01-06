let
  base = {
    vim = {
      lsp = {
        enable = false;
        scala = {
          enable = false;
        };
        nix.enable = false;
      };
    };
  };

  scala = {
    vim.lsp.enable = true;
    vim.lsp.scala.enable = true;
    vim.lsp.nix.enable = false;
  };

  nix = {
    vim.lsp.enable = true;
    vim.lsp.scala.enable = false;
    vim.lsp.nix.enable = true;
  };

in {
  base = base;
  scala = scala;
  nix = nix;
}
