local palette = {
    bg = {
        dark = "github_dark_dimmed",
        light = "vscode",
    },
    tab = {
        dark = "github_dark_dimmed",
        light = "github_light",
    }
}

local M = {}

function M.tab()
    return palette.tab[vim.o.background]
end

function M.bg()
    return palette.bg[vim.o.background]
end

function M.refresh()
    pcall(vim.cmd.colorscheme, M.bg())
    -- FIXME: this is most certainly wrong. setup() shouldn't be called more
    -- than once.
    require("lualine").setup({ options = { theme = M.tab() } })
end

return M
