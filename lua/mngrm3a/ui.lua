-- -----------------------------------------------------------------------------
-- section: diagnosticts
-- -----------------------------------------------------------------------------
local function setup_diagnostics_ui()
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = '✘',
                [vim.diagnostic.severity.WARN] = '▲',
                [vim.diagnostic.severity.HINT] = '⚑',
                [vim.diagnostic.severity.INFO] = '»',
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
-- section: gitblame
-- -----------------------------------------------------------------------------
local gitblame_options = {
    enabled = true,
    date_format = "%c",
    message_template = "  <author> • <date> • <summary>",
    message_when_not_committed = "  Not Committed Yet",
    highlight_group = "Comment",
    set_extmark_options = {},
    display_virtual_text = true,
    ignored_filetypes = {},
    delay = 250,
    virtual_text_column = nil,
    use_blame_commit_file_urls = false,
    schedule_event = "CursorMoved",
    clear_event = "CursorMovedI",
}

-- -----------------------------------------------------------------------------
-- section: lualine
-- -----------------------------------------------------------------------------
local lualine_options = {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { function()
            return require("gitblame").get_current_blame_text() or ""
        end },
        lualine_y = { 'filetype', 'encoding', 'fileformat' },
        lualine_z = { 'progress', 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
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
-- section: fidget
-- -----------------------------------------------------------------------------
-- https://github.com/j-hui/fidget.nvim/blob/main/lua/fidget.lua
local figet_options = {}

-- -----------------------------------------------------------------------------
-- section: setup
-- -----------------------------------------------------------------------------
local M = {}

function M.setup()
    require("gruvbox").setup(gruvbox_options)
    vim.cmd("colorscheme gruvbox")

    require("gitblame").setup(gitblame_options)
    vim.g.gitblame_display_virtual_text = 0

    require("lualine").setup(lualine_options)

    -- require("fidget").setup(fidget_options)
    require("noice").setup(noice_options)

    setup_diagnostics_ui()
end

return M
