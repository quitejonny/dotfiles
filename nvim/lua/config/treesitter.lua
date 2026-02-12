local filetypes = {
    "perl",
    "typescript",
    "vue",
    "javascript",
    "html",
    "css",
    "scss",
    "elixir",
    "go",
}

require('nvim-treesitter').install(filetypes)

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function() vim.treesitter.start() end,
})
