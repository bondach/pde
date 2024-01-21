{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.neo-tree pkgs.plugins.plenary pkgs.plugins.nui pkgs.plugins.web-devicons];

  config.vim.luaConfigRC = ''
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      popup_border_style = "rounded",
    })

    vim.keymap.set('n', '<leader><Tab>', '<cmd>Neotree focus toggle<cr>', { desc = 'file tree' })
  '';
}
