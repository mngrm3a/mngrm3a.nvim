local theme = require("config.theme")

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff" },
            lualine_c = { "filename" },
            lualine_x = { "searchcount", "selectioncount", "diagnostics" },
            lualine_y = { "encoding", "fileformat", "filetype" },
            lualine_z = { "location", "progress" }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {
            lualine_a = { "buffers" },
            lualine_z = { "tabs" }
        },
    }
}
