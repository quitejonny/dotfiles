local opts = { noremap=true, silent=true }
local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local function general_on_attach(client, bufnr)
    local function map(mapping, command)
        buf_keymap(bufnr, 'n', mapping, command, opts)
    end
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    map('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require('lspconfig').tsserver.setup({
    init_options = require("nvim-lsp-ts-utils").init_options,
    automatic_installation = true,
    on_attach = function(client, bufnr)
        general_on_attach(client, bufnr)

        local ts_utils = require("nvim-lsp-ts-utils")

        ts_utils.setup({
            enable_import_on_completion = true,
        })
        ts_utils.setup_client(client)

        buf_keymap(bufnr, "n", "<leader>lo", ":TSLspOrganize<CR>", opts)
        buf_keymap(bufnr, "n", "<leader>lrf", ":TSLspRenameFile<CR>", opts)
        buf_keymap(bufnr, "n", "<leader>lia", ":TSLspImportAll<CR>", opts)
    end,
})

require('lspconfig').vuels.setup({})
