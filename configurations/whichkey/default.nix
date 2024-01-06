{ pkgs, config, ... }:

let
  cfg = config.vim.lsp;
  writeIf = cond: msg: if cond then msg else "";
in

{
  config.vim.plugins = [ pkgs.plugins.which-key ];

  config.vim.luaConfigRC = ''
    vim.o.timeout    = true
    vim.o.timeoutlen = 500
    
    local which_key = require('which-key')
    which_key.setup({})
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
            ${writeIf cfg.scala.enable ''
              ["<leader>m"] = { name = "[METALS]" },
            ''
            }
          })
        end,
      })
    ''
    }

  '';
}
