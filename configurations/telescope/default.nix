{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.telescope pkgs.plugins.plenary ];

  config.vim.luaConfigRC = ''
    require("telescope").setup {
      defaults = {
        vimgrep_arguments = {
          "${pkgs.ripgrep}/bin/rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case"
        },
        --border = {},
        --borderchars = { "▔", "▕", "▁",  "▏", "🭽",  "🭾",  "🭿",  "🭼", },
        color_devicons = true,
        prompt_prefix = " 󰭎  " ,
        set_env = { ["COLORTERM"] = "truecolor" },
        selection_caret = " ",
        entry_prefix = " ",
        path_display = {
          shorten = { len = 1, },
          "truncate",
        },
        dynamic_preview_title = false,
        --[[
        path_display = function(opts, path)
          local utils = require('telescope.utils')
          local tail = utils.path_tail(path)
          return string.format("%s (%s)", tail, path)
        end,
        --]]
        pickers = {
          find_command = {
            "${pkgs.fd}/bin/fd",
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'find files' })

    vim.keymap.set('n', '<leader>fS', '<cmd>Telescope live_grep<cr>', { desc = 'find string' })

  '';
}
