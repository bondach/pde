{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.bqf ];

  config.vim.config.lua.bqf  = ''
    --[[
    require('bqf').setup({
        -- make `drop` and `tab drop` to become preferred
        func_map = {
            drop = 'o',
            openc = 'O',
            split = '<C-s>',
            tabdrop = '<C-t>',
            -- set to empty string to disable
            tabc = "",
            ptogglemode = 'z,',
        },
        filter = {
            fzf = {
                action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
                extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
            }
        }
    })
    --]]
    require('bqf').setup({
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏'},
        show_title = false,
        winblend = 0,
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
              -- skip file size greater than 100k
              ret = false
          elseif bufname:match('^fugitive://') then
              -- skip fugitive buffer
              ret = false
          end
          return ret
        end,
      },
    })
  '';
}
