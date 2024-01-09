{ inputs, config, target, javaPlatform, ... }:

[
  (import ./java.nix { inherit javaPlatform; })
  (import ./clojure.nix { inherit inputs; })
  (import ./metals.nix)
  (import ./treesitter.nix { inherit inputs; })
  (import ./plugins.nix { inherit inputs; })
  (import ./neovim.nix { inherit inputs config; })
  (import ./pde.nix { inherit target; })
]
