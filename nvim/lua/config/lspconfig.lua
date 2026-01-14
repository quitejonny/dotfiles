local keymap = vim.keymap.set

local diag_opts = { noremap = true, silent = true }

keymap("n", "<space>e", vim.diagnostic.open_float, diag_opts)
keymap("n", "[d", vim.diagnostic.goto_prev, diag_opts)
keymap("n", "]d", vim.diagnostic.goto_next, diag_opts)
keymap("n", "<space>q", vim.diagnostic.setloclist, diag_opts)

vim.lsp.config("ts_ls", {
    framework = "vue",
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
    },
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = os.getenv("DEVBOX_PACKAGES_DIR") .. "/lib/node_modules/@vue/typescript-plugin",
                languages = {"javascript", "typescript", "vue"},
            },
        },
    },
})

vim.lsp.config("elixirls", {
  settings = {
    elixirLS = {
      fetchDeps = false,
      dialyzerEnabled = false,
    },
  },
})

vim.lsp.enable("eslint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("elixirls")

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.js,*.ts,*.jsx,*.tsx,*.vue",
    command = "LspEslintFixAll",
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.ex,*.exs,*.eex,*.heex",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
