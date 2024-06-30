local M = {}

function M.setup()
    require("mngrm3a.keymap").setup(" ", " ")
    require("mngrm3a.options")
    require("mngrm3a.ui").setup()
    require("mngrm3a.treesitter").setup()
    require("mngrm3a.telescope").setup()
    require("mngrm3a.lsp").setup(vim.log.levels.DEBUG)
    require("mngrm3a.completion").setup()
    require("mngrm3a.vcs").setup()
    require("mngrm3a.comments").setup()
    require("mngrm3a.utils").setup()
end

return M
