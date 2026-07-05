return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            { "<leader>t", group = "Tools" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>l", group = "LSP" },
            { '<leader>§', group = 'Vim' },
            { '<C-t>',     group = 'Tabs' },
        },
    },
    keys = {
        { '<C-t>q', '<cmd>tabclose<CR>',    desc = 'Close' },
        { '<C-t>p', '<cmd>tabprevious<CR>', desc = 'Previous' },
        { '<C-t>P', '<cmd>tabfirst<CR>',    desc = 'First' },
        { '<C-t>n', '<cmd>tabnext<CR>',     desc = 'Next' },
        { '<C-t>N', '<cmd>tablast<CR>',     desc = 'Last' },
    }
}
