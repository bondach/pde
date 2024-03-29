{ pkgs, lib ? pkgs.lib, ... }:

with lib;

{
  config.vim.config.lua.basic = ''
      vim.loader.enable()

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

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.opt.incsearch = true
      vim.opt.fileencoding = "utf-8"
      vim.opt.mouse = "a"

      vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")       -- no numbers
      vim.api.nvim_command("autocmd TermOpen * setlocal norelativenumber") -- no relative numbers
      vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no") -- no sign column
      vim.keymap.set('t', '<esc>', "<C-\\><C-n>")                    -- esc to exit insert mode

      vim.opt.numberwidth = 5
      vim.opt.statuscolumn = ' %s%=%{v:relnum?v:relnum:v:lnum}%#WinSeparator#  '
      vim.opt.pumheight = 10
      --[[
          glyphs = {
        default = '󰈔',
        folder = {
            arrow_closed = '',
            arrow_open = '',
            default = ' ',
            open = ' ',
            empty = ' ',
            empty_open = ' ',
            symlink = '󰉒 ',
            symlink_open = '󰉒 ',
        },
        git = {
            deleted = '',
            unstaged = '',
            untracked = '',
            staged = '',
            unmerged = '',
        },
      --]]

    '';
}
