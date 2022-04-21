vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]],
    }
    use 'tpope/vim-fugitive'
    use {
        'L3MON4D3/LuaSnip',
        config = [[require('config.luasnip')]]
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require('config.lspconfig')]]
    }
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = [[require('config.null_ls')]],
        requires = { "nvim-lua/plenary.nvim" }
    })

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = [[require('config.telescope')]]
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
end)
