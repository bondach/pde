{ ... }:


{
  config.vim = {
    luaConfigRC = ''
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.showmatch = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.smartindent = true
      vim.opt.clipboard = 'unnamedplus'
      vim.opt.expandtab = true
      vim.opt.number = true
      vim.opt.wrap = false
      vim.opt.relativenumber = true
      vim.o.termguicolors = true
      vim.opt.laststatus = 3
      vim.wo.cursorline = true
      vim.g.mapleader = ' '
      vim.g.loaded_ruby_provider = 0
      vim.g.loaded_python3_provider = 0
      vim.g.loaded_perl_provider = 0
      vim.g.loaded_node_provider = 0
      vim.opt.shortmess:append "sI"
      vim.opt.formatoptions:remove { 'c', 'r', 'o' }

      vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")       -- no numbers
      vim.api.nvim_command("autocmd TermOpen * setlocal norelativenumber") -- no relative numbers
      vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no") -- no sign column
      vim.keymap.set('t', '<esc>', "<C-\\><C-n>")                    -- esc to exit insert mode
    '';
  };
}
