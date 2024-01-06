f: p:

let
  version = "1.2.0";
  outputHash = "sha256-nikQ/GFRWmYYzboc9TWIi9gd5kwgCxOLhvIEQWusFik=";
  deps = p.stdenv.mkDerivation {
    name = "metals-${version}";
    buildCommand = ''
      export COURSIER_CACHE=$(pwd)
      ${p.coursier}/bin/cs fetch org.scalameta:metals_2.13:${version} \
        -r bintray:scalacenter/releases \
        -r sonatype:snapshots > deps
      mkdir -p $out/share/java
      cp -n $(< deps) $out/share/java
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    inherit outputHash;
  };
in {
  metals = p.metals.overrideAttrs(old: {
    inherit version;
    extraJavaOpts = old.extraJavaOpts + " -Dmetals.client=nvim-lsp";
    buildInputs = [ deps ];
  });
}
