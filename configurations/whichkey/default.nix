{ pkgs, config, ... }:

let
  cfg = config.vim.lsp;
  writeIf = cond: msg: if cond then msg else "";
in

{
  config.vim.plugins = [ pkgs.plugins.which-key ];

  config.vim.config.lua.whichkey = ''
    vim.o.timeout    = true
    vim.o.timeoutlen = 500
    
    local which_key = require('which-key')
    which_key.setup({
      window = {
        border = { "", "▔", "", "", "", " ", "", "" },
        margin = { 0, 0, 1, 0 },
        padding = { 0, 0, 0, 0 },
      },
    })
    which_key.register({
      ["<leader>f"] = { name = "find" },
      ["<leader>g"] = { name = "git" },
      ["<leader>gt"] = { name = "toggle" },
    })

    ${writeIf cfg.enable ''
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          which_key.register({
            ["<leader>fs"] = { name = "symbols [LSP]"},
            ["<leader>x"] = { name = "diagnostics"},
            ${writeIf cfg.scala.enable ''
              ["<leader>m"] = { name = "Metals" },
            ''
            }
            ${writeIf cfg.clojure.enable ''
              ["<leader>e"] = { name = "eval [CONJURE]" },
              ["<leader>c"] = { name = "Conjure" },
              ["<leader>cl"] = { name = "Log" },
              ["<leader>clr"] = { name = "reset" },
            ''
            }
          })
        end,
      })
    ''
    }

  '';
}
