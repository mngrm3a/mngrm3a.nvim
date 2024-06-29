-- -----------------------------------------------------------------------------
-- section: diagnosticts
-- -----------------------------------------------------------------------------
local function setup_diagnostics_ui()
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "▲",
                [vim.diagnostic.severity.HINT] = "⚑",
                [vim.diagnostic.severity.INFO] = "»",
            },
        },
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })
end

-- -----------------------------------------------------------------------------
-- section: colorschemes
-- -----------------------------------------------------------------------------
local gruvbox_options =
{
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "",  -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
}

-- -----------------------------------------------------------------------------
-- section: lualine
-- -----------------------------------------------------------------------------
local lualine_options = {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype", "searchcount", "selectioncount" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
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
    inactive_winbar = {},
    extensions = {}
}

-- -----------------------------------------------------------------------------
-- section: noice
-- -----------------------------------------------------------------------------
local noice_options = {
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
}

-- -----------------------------------------------------------------------------
-- section: setup
-- -----------------------------------------------------------------------------
local M = {}

function M.setup()
    require("gruvbox").setup(gruvbox_options)
    vim.cmd("colorscheme gruvbox")
    require("lualine").setup(lualine_options)
    require("noice").setup(noice_options)
    setup_diagnostics_ui()
end

return M
