local function make_lualine_config(theme)
    return {
        options = {
            theme = theme,
        },
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
end

local M = {}

function M.setThemeMode(mode)
    local theme = {
        vim = {
            light = 'vscode',
            dark = 'github_dark_dimmed',
        },
        lualine = {
            light = 'github_light_default',
            dark = 'auto'
        },
    }

    if mode ~= 'light' or mode ~= 'dark' then
        if mode == 'auto' then
            mode = vim.o.background
        else
            mode = vim.o.background == 'light' and 'dark' or 'light'
        end
    end

    vim.o.background = mode
    vim.cmd("colorscheme " .. theme['vim'][mode])
    require("lualine").setup(
        make_lualine_config(theme['lualine'][mode])
    )
end

function M.setup()
    require("noice").setup({
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
    })

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
            source = true,
            header = "",
            prefix = "",
        },
    })
    
    require('github-theme').setup()
    require('vscode').setup()
    
    M.setThemeMode('auto')
end

return M
