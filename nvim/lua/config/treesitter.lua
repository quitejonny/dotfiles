require('nvim-treesitter.configs').setup({
  ensure_installed = { "perl", "typescript", "vue", "javascript", "html", "css", "scss" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { "perl" },
  },
})
