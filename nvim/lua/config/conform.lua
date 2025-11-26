require("conform").setup({
    formatters_by_ft = {
        perl = { "perltidy" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        vue = { "eslint_d" },
    },
    format_on_save = {
        timeout_ms = 2000,
    },
})

