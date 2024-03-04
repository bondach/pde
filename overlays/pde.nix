{ target, ...}:

f: p: let
in
if (target == "scala") then
{
  pde = p.mkShell {
    packages = [ p.neovim p.jdk p.sbt p.mill p.metals p.coursier
                 p.ripgrep p.fd ];
    shellHook = ''
      JAVA_HOME=${p.jdk}/bin
      echo "Welcome to Scala dev environment!"
    '';
  };
}
else if (target == "clojure") then
{
  pde = p.mkShell {
    name = "pde";
    packages = [ p.neovim p.jdk p.clojure-lsp p.clojure p.unzip p.leiningen p.ripgrep p.fd p.fish ];
    shellHook = ''
      JAVA_HOME=${p.jdk}/bin
      echo "Welcome to Clojure dev environment!"
    '';
  };
}
else if (target == "lua") then
{
  pde = p.mkShell {
    name = "pde";
    packages = [ p.neovim p.fish p.sumneko-lua-language-server ];
    shellHook = ''
      echo "Welcom to Lua dev environment!"
    '';

  };
}
else if (target == "nix") then
{
  pde = p.mkShell {
    name = "nix";
    packages = [ p.neovim p.fish p.nixd ];
    shellHook = ''
      echo "Welcom to Nix dev environment!"
    '';

  };
}

else { }


