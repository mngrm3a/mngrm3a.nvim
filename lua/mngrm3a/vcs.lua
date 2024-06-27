--------------------------------------------------------------------------------
-- section: setup
--------------------------------------------------------------------------------
local M = {}

function M.setup()
    require("gitsigns").setup()
    require("neogit").setup()
end

return M
