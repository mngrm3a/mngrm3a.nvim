--------------------------------------------------------------------------------
-- section: setup
--------------------------------------------------------------------------------
local M = {}

function M.setup()
    require("gitsigns").setup({
        on_attach = require("mngrm3a.keymap").setup_gitsigns_keymap
    })
    require("neogit").setup()
end

return M
