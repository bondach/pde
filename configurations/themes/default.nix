{ pkgs, ... }:


{
  config = {
    vim.plugins = [ pkgs.plugins.kanagawa ]; 

    vim.luaConfigRC = ''
      require('kanagawa').setup({
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        theme = "wave",
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle  = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
  
      vim.cmd.colorscheme('kanagawa')
    '';
  };
}


