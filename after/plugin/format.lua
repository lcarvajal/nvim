vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ex", "*.exs" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

