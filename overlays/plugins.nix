{ inputs, ... }:

f: p:

with builtins;

let
  prefix = "np-";
  isPlugin = str: (match "${prefix}.*" str) != null;
  prettyName = str: substring (stringLength prefix) (stringLength str) str;
  names = filter isPlugin (attrNames inputs);
  buildFunc = name:
    let
      name' = prettyName name;
    in {
      name = name';
      value = p.vimUtils.buildVimPlugin {
        pname = name';
        version = inputs.${name}.rev;
        src = inputs.${name};
        preFixup = if (name' == "treesitter") then p.treesitterPreFixupHook else "";
        postPatch = if (name' == "treesitter") then p.treesitterPostPatchHack else "";
      };
    };
in {
  plugins = listToAttrs(map buildFunc names);
}

