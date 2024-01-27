{ pkgs, ... }:


{
  config = {
    vim.plugins = [ pkgs.plugins.kanagawa ]; 

    vim.config.lua.themes = ''
      require('kanagawa').setup({
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        theme = "wave",
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = theme.ui.bg_m1 },
            FloatBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m1, },
            FloatTitle  = { bg = theme.ui.bg_m1 },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            --Pmenu = { bg = theme.ui.bg_m1 },
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p1 },
            WinSeparator = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
            NeoTreeNormal = { bg = theme.ui.bg_m1 },
            NeoTreeNormalNC = { bg = theme.ui.bg_m1 },
            NeoTreeWinSeparator = { fg = theme.ui.bg_p2, bg = theme.ui.bg_m1 },
            CursorLine = { bg = theme.ui.bg_p1 }, 
            BqfPreviewBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m1 },
            BqfPreviewFloat = { bg = theme.ui.bg_m1 },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
            wave = {
            },
          },
        },
      })
  
      vim.cmd.colorscheme('kanagawa')
    '';
  };
}


