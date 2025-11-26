local opts = { noremap=true, silent=true }
local keymap = vim.keymap.set
local buf_keymap = vim.api.nvim_buf_set_keymap

keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local function general_on_attach(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    local function map(mapping, command, opts)
        vim.keymap.set('n', mapping, command, opts)
    end
    -- client.server_capabilities.documentFormattingProvider = false
    -- client.server_capabilities.documentRangeFormattingProvider = false
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    map('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', bufopts)
    map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
    map('K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
    map('gr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
    map('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopts)
    map('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
    map('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
    map('<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', bufopts)
end

local npm = "/home/roos/.nvm/versions/node/v20.18.2/lib/node_modules/"

require('lspconfig').ts_ls.setup({
    init_options = require("nvim-lsp-ts-utils").init_options,
    automatic_installation = true,
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = npm .. "@vue/typescript-plugin",
                languages = {"javascript", "typescript", "vue"},
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "vue",
    },
    on_attach = function(client, bufnr)
        general_on_attach(client, bufnr)

        local ts_utils = require("nvim-lsp-ts-utils")

        ts_utils.setup({
            enable_import_on_completion = true,
        })
        ts_utils.setup_client(client)

        local bufopts = { unpack(opts), buffer=bufnur }
        vim.keymap.set("n", "<leader>lo", ":TSLspOrganize<CR>", bufopts)
        vim.keymap.set("n", "<leader>lrf", ":TSLspRenameFile<CR>", bufopts)
        vim.keymap.set("n", "<leader>lia", ":TSLspImportAll<CR>", bufopts)
    end,
})

require('lspconfig').eslint_d.setup({
    on_attach = function(client, bufnr)
        general_on_attach(client, bufnr)
    end,
})

require'lspconfig'.elixirls.setup({
    cmd = { vim.fn.expand("~/elixir-ls/language_server.sh") },
    on_attach = function(client, bufnr)
        general_on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ buffer=bufnr, async = false }) end,
        })
    end,
    settings = {
        elixirLS = {
            fetchDeps = false,
            dialyzerEnabled = false,
        },
    },
})
