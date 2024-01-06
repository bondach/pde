{ pkgs, ... }:


{
  config.vim.plugins = [ pkgs.plugins.ufo pkgs.plugins.promise-async ];

  config.vim.luaConfigRC = ''
    vim.o.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn     = '1'
    vim.o.foldlevel      = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable     = true
    
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "open all folds", })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "close all folds", })
    
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
  '';
}
