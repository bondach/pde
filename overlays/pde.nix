{ target, ...}:

f: p: let
in
if (target == "scala") then
{
  pde = p.mkShell {
    packages = [ p.neovim p.jdk p.sbt p.bloop p.mill p.metals p.coursier
                 p.ripgrep p.fd p.fish ];
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
else { }


