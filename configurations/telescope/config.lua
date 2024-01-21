local telescope = require('telescope')
local action_layout = require('telescope.actions.layout')
telescope.load_extension("live_grep_args")

local function telescope_setup(ripgrep, fd)
  telescope.setup {
    defaults = {
      mappings = {
        n = {
          ["<C-p>"] = action_layout.toggle_preview
        },
        i = {
          ["<C-p>"] = action_layout.toggle_preview
        },
      },
      vimgrep_arguments = {
        ripgrep,
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
      --border = {},
      --borderchars = { "▔", "▕", "▁",  "▏", "🭽",  "🭾",  "🭿",  "🭼", },
      color_devicons = true,
      prompt_prefix = " 󰭎  " ,
      set_env = { ["COLORTERM"] = "truecolor" },
      selection_caret = " ",
      entry_prefix = " ",
      --path_display = filename_first,
      dynamic_preview_title = false,
    },
    pickers = {
      find_command = { fd, },
    },
  }
end

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', { desc = 'find grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'find buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'find help tags' })

