{ inputs,...}:

f: p:
let
  build = name:
    let
      key = "ts-g-${name}";
    in
      p.tree-sitter.buildGrammar {
        language = name;
        version = inputs.${key}.rev;
        src = inputs.${key};
      };
  #TODO: rework with filter and map
  tsGrammars = p.tree-sitter.withPlugins(tp: [
    (build "scala")
    (build "bash")
    (build "vimdoc")
    (build "sql")
    (build "java")
    (build "plantuml")
    (build "rust")
    (build "zig")
    (build "clojure")
    (build "proto")
    (build "hocon")
    (build "fish")
    (build "vim")
    (build "toml")
    (build "nix")
    (build "json")
    (build "http")
    (build "gitignore")
   #TODO: errors in checkhealth
   #(build "gitrebase")
   #(build "gitconfig")
    (build "gitcommit")
    (build "diff")
  ]);
in {
  treesitterPreFixupHook = ''
    cp ${inputs.ts-g-scala}/queries/scala/* $out/queries/scala
  '';

  treesitterPostPatchHack = ''
    rm -r parser
    ln -s ${tsGrammars} parser
  '';
}
