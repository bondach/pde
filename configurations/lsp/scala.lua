local function metals_setup(jdk, metals)
  vim.opt_global.shortmess:remove("F")

  local metals_config = require("metals").bare_config()
  metals_config.init_options.statusBarProvider = "on"
  --metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()
  metals_config.settings = {
    javaHome = jdk,
    enableSemanticHighlighting = true,
    metalsBinaryPath = metals,
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    --testUserInterface = "Test Explorer",
  }
  metals_config.handlers = lsp_handlers
  metals_config.on_attach = function(client, bufnr)
    require("metals").setup_dap()

  end

  require("dap").configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "RunOrTest",
      metals = {
        runType = "runOrTestFile",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
  }

  local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

  local overrideColors = function()
    local colors = require("kanagawa.colors").setup({ theme = 'wave' }).palette

    vim.api.nvim_set_hl(0, '@lsp.type.namespace.scala', { fg = colors.oldWhite })
    vim.api.nvim_set_hl(0, '@lsp.mod.readonly.scala',   { fg = colors.fujiWhite })
    vim.api.nvim_set_hl(0, '@lsp.type.modifier.scala',  { fg = colors.oniViolet, italic=true })
    vim.api.nvim_set_hl(0, '@lsp.type.keyword.scala',   { fg = colors.oniViolet })
    vim.api.nvim_set_hl(0, '@keyword.operator.scala',   { fg = colors.oniViolet })
    vim.api.nvim_set_hl(0, '@conditional.scala',        { fg = colors.oniViolet })
    vim.api.nvim_set_hl(0, '@boolean.scala',            { fg = colors.oniViolet })
  end


  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java", "sc" },
    callback = function()
      require('metals').initialize_or_attach(metals_config)
      vim.keymap.set('n', '<leader>md', "<cmd>MetalsRunDoctor<cr>", { desc = "run doctor [METALS]" })
      vim.keymap.set('n', '<leader>mi', "<cmd>MetalsInfo<cr>", { desc = "info [METALS]" })
      vim.keymap.set('n', '<leader>ml', "<cmd>MetalsToggleLogs<cr>", { desc = "logs [METALS]" })
      vim.keymap.set('n', '<leader>mc', require("telescope").extensions.metals.commands, { desc = "all commands [METALS]" })
      vim.keymap.set('n', '<leader>D', require('dap').repl.toggle, { desc = "repl toggle [DAP]" })
      overrideColors()

    end,
    group = nvim_metals_group,
  })
end
