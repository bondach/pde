{ pkgs, lib ? pkgs.lib, config, ... }:

with lib;

let
  cfg = config.vim.lsp;
  writeIf = cond: msg: if cond then msg else "";
in {
  options.vim.lsp.lua.enable = mkEnableOption "Lua LSP (sumneko-lua-language-server)";

  config = mkIf (cfg.enable && cfg.lua.enable) {
    vim.plugins = [ pkgs.plugins.lspconfig ];
    vim.luaConfigRC = ''
      require('lspconfig').lua_ls.setup{
        cmd = {
          '${pkgs.sumneko-lua-language-server}/bin/lua-language-server'
        },
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", }),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", }),
        },
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                },
                workspace = {
                  checkThirdParty = false,
                  library = vim.api.nvim_get_runtime_file("", true),
                },
              },
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end,
      }
    '';
  };
}
