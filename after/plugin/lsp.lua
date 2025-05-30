local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "elixir_ls" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = lsp_capabilities
      })
    end,
  },
})

