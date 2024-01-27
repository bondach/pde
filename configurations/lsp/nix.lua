local function nix_setup(lsp_server)
  require('lspconfig').nixd.setup {
    cmd = { lsp_server },
  }
end
