return {
    "stevearc/conform.nvim",
    opts = {
        default_format_opts = {
            lsp_format = "prefer",
            timeout_ms = 500,
        },
        formatters_by_ft = {
            python = { "ruff_format" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            go = { "goimports", "gofmt" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "prefer",
        },
    },
    keys = {
        {
            '<leader>lf',
            function()
                require("conform").format({ async = true }, nil)
            end,
            desc = 'Format'
        },
    }
}
