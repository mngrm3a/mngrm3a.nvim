local M = {}

function M.setup()
    local keymap = require("mngrm3a.keymap")
    keymap.setup_leaders(",", ",")

    require("mngrm3a.options")
    require("mngrm3a.ui").setup()
    
    require("mngrm3a.treesitter").setup()
    
    require("mngrm3a.telescope").setup()
    keymap.setup_telescope_keymap()

    require("mngrm3a.lsp").setup()
    keymap.setup_lsp_keymap()
    
    require("mngrm3a.completion").setup()
    require("mngrm3a.vcs").setup()
    require("mngrm3a.comments").setup()
    require("mngrm3a.utils").setup()
end

return M
