local t_builtin = require('telescope.builtin')

-------------------------------------
---------- lsp_references -----------
-------------------------------------
local lsp_references_displayer = require('telescope.pickers.entry_display').create({
  separator = ' ',
  items = {
    { width = 1 },
    { width = nil },
    { remaining = true },
  },
})

local lsp_references_opts = {show_line=false, include_declaration=false}
local lsp_references_entry_make = require('telescope.make_entry').gen_from_quickfix(lsp_references_opts)

local function lsp_references()
  lsp_references_opts.entry_maker = function(line)
    local entry = lsp_references_entry_make(line)
    entry.display = function(_entry)
      local value = _entry.value
      local file  = vim.fs.basename(value.filename)
      local icon, iconhl = require('telescope.utils').get_devicons(file)
      file = vim.fn.fnamemodify(file, ":r")
      local path  = vim.fs.dirname(value.filename):gsub(vim.loop.cwd():gsub('%-', '%%-'), '')
      return lsp_references_displayer({
        { icon, iconhl },
        file..'#'.._entry.lnum,
        { path, 'TelescopeResultsComment' }
      })
    end
    return entry
  end
  t_builtin.lsp_references(lsp_references_opts)
end

-------------------------------------
-------- lsp_implementations --------
-------------------------------------
-- TODO: right now it is just copy of lsp_references function
local lsp_implementations_displayer = require('telescope.pickers.entry_display').create({
  separator = ' ',
  items = {
    { width = 1 },
    { width = nil },
    { remaining = true },
  },
})

local lsp_implementations_opts = {show_line=false}
local lsp_implementations_entry_make = require('telescope.make_entry').gen_from_quickfix(lsp_references_opts)

local function lsp_implementations()
  lsp_implementations_opts.entry_maker = function(line)
    local entry = lsp_implementations_entry_make(line)
    entry.display = function(_entry)
      local value = _entry.value
      local file  = vim.fs.basename(value.filename)
      local icon, iconhl = require('telescope.utils').get_devicons(file)
      file = vim.fn.fnamemodify(file, ":r")
      local path  = vim.fs.dirname(value.filename):gsub(vim.loop.cwd():gsub('%-', '%%-'), '')
      return lsp_implementations_displayer({
        { icon, iconhl },
        file..'#'.._entry.lnum,
        { path, 'TelescopeResultsComment' }
      })
    end
    return entry
  end

  t_builtin.lsp_implementations(lsp_implementations_opts)
end
