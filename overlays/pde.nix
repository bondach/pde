{ target, ...}:

f: p: let
in
if (target == "scala") then
{
  pde = p.symlinkJoin {
    name = "pde";
    paths = [ p.neovim p.jdk p.sbt p.bloop p.mill p.metals p.coursier]; 
  };
}
else if (target == "clojure") then
{
  pde = p.symlinkJoin {
    name = "pde";
    paths = [ p.neovim p.jdk p.clojure-lsp p.clojure p.unzip p.leiningen ];
  };
}
else {
  pde = p.neovim;
}


