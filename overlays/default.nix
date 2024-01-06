{ inputs, system, config, target, ... }:

[
  (import ./java.nix)
  (import ./metals.nix)
  (import ./treesitter.nix { inherit inputs; })
  (import ./plugins.nix { inherit inputs; })
  (import ./neovim.nix { inherit inputs system config; })
  (import ./pde.nix { inherit target; })
]
