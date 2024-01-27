{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.gitsigns ];

  config.vim.config.lua.gitsigns = ''
    -- TODO: сделать так, чтобы gitsigns врубался, если произошла смена рабочей директории на ту, в которой есть git репозиторий
    function gitsigns_setup()
      local git_dir = vim.fn.finddir('.git', vim.fn.getcwd() .. ';')
      if git_dir ~= "" then 
        require('gitsigns').setup()
        vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns blame_line<cr>', { desc = 'blame line' })
        vim.keymap.set('n', '<leader>gn', '<cmd>Gitsigns next_hunk<cr>', { desc = 'next hunk' })
        vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'prev hunk' })
        vim.keymap.set('n', '<leader>gv', '<cmd>Gitsigns preview_hunk<cr>', { desc = 'preview hunk' })
        vim.keymap.set('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', { desc = 'reset hunk' })
        vim.keymap.set('n', '<leader>gts', '<cmd>Gitsigns toggle_signs<cr>', { desc = 'signs' })
        vim.keymap.set('n', '<leader>gtw', '<cmd>Gitsigns toggle_word_diff<cr>', { desc = 'word diff' })
        vim.keymap.set('n', '<leader>gtd', '<cmd>Gitsigns toggle_deleted<cr>', { desc = 'deleted' })
      end
    end

    gitsigns_setup()
  '';
}
