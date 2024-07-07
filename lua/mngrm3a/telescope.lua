local telescope_options = {
    defaults = {
        layout_strategy = 'vertical',
        layout_config = { width = 0.95, height = 0.95 },
    },
}
-- -----------------------------------------------------------------------------
-- section: setup
-- -----------------------------------------------------------------------------
local M = {}

function M.setup()
    require("telescope").setup(telescope_options)
    require('telescope').load_extension("fzf")
end

return M
