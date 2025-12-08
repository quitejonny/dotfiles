local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },
  "tpope/vim-fugitive",
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("config.luasnip")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lspconfig")
    end,
  },
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  -- Same as your commented-out null-ls block
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("config.null_ls")
  --   end,
  -- },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("config.copilot")
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("config.conform")
    end,
  },
})
