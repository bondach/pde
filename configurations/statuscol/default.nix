{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.statuscol ];

  config.vim.luaConfigRC = ''
    -- Stealed from here
    -- https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1512724088
    local statuscol_builtin = require("statuscol.builtin")
    require("statuscol").setup({
      ft_ignore = {
        "neo-tree",
        "dap-repl"
      },
      segments = {
        { text = { statuscol_builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        { text = { "%s" }, click = "v:lua.ScFa" },
        {
          text = { statuscol_builtin.lnumfunc, " " },
          condition = { true, statuscol_builtin.not_empty },
          click = "v:lua.ScLa",
        },
      },
    })
  '';
}
