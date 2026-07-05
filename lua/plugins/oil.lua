return {
    'stevearc/oil.nvim',
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
    config = function()
        require("oil").setup()
    end,
    keys = {
        { '<leader>tf', ':Oil<CR>', desc = 'File Manager' },
    }
}
