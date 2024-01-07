{ pkgs, lib ? pkgs.lib, config, ... }:

with lib;

let
  cfg = config.vim.lsp;
  writeIf = cond: msg: if cond then msg else "";
in {
  options.vim.lsp.clojure.enable = mkEnableOption "Clojure LSP (nixd)";

  config = mkIf (cfg.enable && cfg.clojure.enable) {
    vim.plugins = [ pkgs.plugins.lspconfig pkgs.plugins.conjure ];
    vim.luaConfigRC = ''
      require('lspconfig').clojure_lsp.setup{
        cmd = {
          '${pkgs.clojure-lsp}/bin/clojure-lsp'
        };
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", }),
        }
      }
      
      -- Стащил отсюда https://github.com/harrisoncramer/nvim/blob/07456c3cca342d2be39af65fe71f4aaa6a011bb1/lua/lsp/servers/clojure_lsp.lua#L1C9-L1C10
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "conjure-log*",
        callback = function()
          local clients = vim.lsp.get_active_clients()
          for _, c in ipairs(clients) do
            vim.lsp.buf_detach_client(0, c.id)
          end
          vim.keymap.set('n', '<leader>cee', "<cmd>ConjureEval<cr>", { desc = "expression", })
          vim.keymap.set('n', '<leader>cew', "<cmd>ConjureEvalBuf<cr>", { desc = "buf", })
          vim.keymap.set('n', '<leader>cef', "<cmd>ConjureEvalFile<cr>", { desc = "file", })
          vim.keymap.set('n', '<leader>clt', "<cmd>ConjureLogToggle<cr>", { desc = "toggle", })
          vim.keymap.set('n', '<leader>clrs', "<cmd>ConjureLogResetSoft<cr>", { desc = "soft", })
          vim.keymap.set('n', '<leader>clrh', "<cmd>ConjureLogResetSoft<cr>", { desc = "hard", })
          vim.keymap.set('n', '<leader>cd', "<cmd>ConjureDefWord<cr>", { desc = "def word", })
        end,
        desc = "Turns off LSP for Conjure's buffer",
      })
    '';
  };
}
