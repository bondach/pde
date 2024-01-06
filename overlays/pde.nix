{ target, ...}:

f: p: let
in
if (target == "scala") then
  {
     pde = p.symlinkJoin {
       name = "pde";
       paths = [ p.neovim p.jdk p.sbt p.bloop p.mill p.metals ]; 
     };
  }
else {
  pde = p.neovim;
}


