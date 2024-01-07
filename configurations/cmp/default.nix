{ pkgs, config, ... }:

let
  cfg = config.vim.lsp;
  writeIf = cond: s: if cond then s else "";
in
{
  config.vim.plugins = [
    pkgs.plugins.nvim-cmp
    pkgs.plugins.cmp-vsnip
    pkgs.plugins.vim-vsnip
    pkgs.plugins.cmp-buffer
    pkgs.plugins.cmp-path
    pkgs.plugins.cmp-cmdline
  ] ++ (if cfg.enable then
   [
    pkgs.plugins.cmp-lsp
    pkgs.plugins.cmp-lsp-signature-help
   ]
   else []) ++ (if (cfg.enable && cfg.clojure.enable) then
   [
    pkgs.plugins.cmp-clojure
   ]
   else []);

  config.vim.luaConfigRC = ''
    local cmp = require('cmp')
    local kind_icons = {
    	Text = "󰊄",
    	Method = "",
    	Function = "󰡱",
    	Constructor = "",
    	Field = "",
    	Variable = "󱀍",
    	Class = "",
    	Interface = "",
    	Module = "󰕳",
    	Property = "",
    	Unit = "",
    	Value = "",
    	Enum = "",
    	Keyword = "",
    	Snippet = "",
    	Color = "",
    	File = "",
    	Reference = "",
    	Folder = "",
    	EnumMember = "",
    	Constant = "",
    	Struct = "",
    	Event = "",
    	Operator = "",
    	TypeParameter = "",
    }

    cmp.setup({
      sources = cmp.config.sources({
        ${writeIf cfg.enable ''{ name = "nvim_lsp" },''}
        { name = "vsnip" },
        ${writeIf cfg.enable ''{ name = "nvim_lsp_signature_help" },''}
        ${writeIf cfg.clojure.enable ''{ name = "conjure" },'' }
      },
      { { name = "buffer" } }),
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = false,
        native_menu = false,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = function(fallback)
          if cmp.visible() then cmp.select_next_item()
          else fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else fallback()
          end
        end,
        ["<C-j>"] = cmp.mapping.scroll_docs(1),
        ["<C-k>"] = cmp.mapping.scroll_docs(-1),
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            path = "[Path]",
            nvim_lua = "[NVIM_LUA]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            ${writeIf cfg.clojure.enable ''conjure = "[Conjure]",''}
          })[entry.source.name]
          return vim_item
        end,
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
      },
    })
    
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    })
  '';
}
