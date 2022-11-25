local null_ls = require("null-ls")
local nls_utils = require("null-ls.utils")

require("null-ls").setup({
    sources = {
        null_ls.builtins.formatting.perltidy,
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.diagnostics.eslint_d,
    },
    debug = true,
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd([[
                augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 3000)
                augroup END
            ]])
        end
    end,
    root_dir = nls_utils.root_pattern ".git",
})

