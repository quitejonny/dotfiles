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

local devbox_dir = os.getenv("DEVBOX_PACKAGES_DIR")
local dexter_bin = devbox_dir and (devbox_dir .. "/bin/dexter")

if dexter_bin and vim.uv.fs_stat(dexter_bin) then
    vim.lsp.config("dexter", {
        cmd = { dexter_bin, "lsp" },
        filetypes = { "elixir", "eelixir", "heex", "surface" },
        root_markers = { "mix.exs" },
    })
    vim.lsp.enable("dexter")
end

vim.lsp.enable("eslint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("gopls")

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.js,*.ts,*.jsx,*.tsx,*.vue",
    command = "LspEslintFixAll",
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.ex,*.exs,*.eex,*.heex,*.go",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
