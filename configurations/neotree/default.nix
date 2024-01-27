{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.neo-tree pkgs.plugins.plenary pkgs.plugins.nui pkgs.plugins.web-devicons];

  config.vim.config.lua.neotree = ''
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      popup_border_style = "rounded",
      default_component_configs = {
        icon = {
          folder_closed = " ",
          folder_open = " ",
          folder_empty = " ",
          folder_empty_open = " ",
          default = "󰈔 ",
          highlight = "NeoTreeFileIcon",
        },
      },
      source_selector = {
        sources = {
          {
            source = "filesystem",
            display_name = "󰉓 Files"
          },
        },
      },
    })

    vim.keymap.set('n', '<leader><Tab>', '<cmd>Neotree focus toggle<cr>', { desc = 'file tree' })

  '';
}
