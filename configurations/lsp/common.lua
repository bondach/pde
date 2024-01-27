local lsp_borders = {
  {"🭽", "FloatBorder"},
  {"▔", "FloatBorder"},
  {"🭾", "FloatBorder"},
  {"▕", "FloatBorder"},
  {"🭿", "FloatBorder"},
  {"▁", "FloatBorder"},
  {"🭼", "FloatBorder"},
  {"▏", "FloatBorder"},
}

local lsp_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = lsp_borders }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = lsp_borders }),
}

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

local diagnostic_opts = {
  focusable = false,
  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  border = lsp_borders,
  source = "always",
  prefix = " ",
  scope = "line"
}

local d_open_float = function()
  vim.diagnostic.open_float(nil, diagnostic_opts)
end

vim.keymap.set('n', '<leader>p', d_open_float, { desc = "show diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local sc = client.server_capabilities

    if sc.hoverProvider then
      vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, { desc = "hover [LSP]" })
    end

    if sc.documentSymbolProvider then
      vim.keymap.set('n', '<leader>fsd', require('telescope.builtin').lsp_document_symbols, { desc = "document [LSP]" })
    end

    if sc.workspaceSymbolProvider then
      vim.keymap.set('n', '<leader>fsw', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = "workspace [LSP]" })
    end

    if sc.definitionProvider then
      vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, { desc = "definition(s) [LSP]" })
    end

    if sc.implementationProvider then
      vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, { desc = "implementation(s) [LSP]" })
    end

    if sc.codeActionProvider then
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = "code action [LSP]" })
    end

    if sc.referencesProvider then
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, { desc = 'reference(s) [LSP]' })
    end

    if sc.renameProvider then
      vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { desc = "rename [LSP]" })
    end

    if sc.signatureHelpProvider then
      vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, { desc = "signature help [LSP]" })
    end

    if sc.typeDefinitionProvider then
      vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, { desc = "type definition [LSP]" })
    end

    if sc.codeLensProvider then
      vim.keymap.set('n', '<leader>l', vim.lsp.codelens.run, { desc = "codelens [LSP]" })
    end

  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave"}, {
  callback = function(args)
    vim.lsp.codelens.refresh()
  end,
})

