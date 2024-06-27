-- -----------------------------------------------------------------------------
-- section: treesitter options
-- -----------------------------------------------------------------------------
local treesitter_options = {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
}

-- -----------------------------------------------------------------------------
-- section: setup
-- -----------------------------------------------------------------------------
local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup(treesitter_options)
end

return M

