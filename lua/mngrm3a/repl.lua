local iron_options = {
    config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
            sh = { command = { "zsh" } }
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = require("iron.view").split.horizontal.botright(0.25, {
            relativenumber = false,
            signcolumn = "no"
        })
        -- repl_open_cmd = require("iron.view").bottom(.025)
    },
    highlight = {
        italic = true
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

local M = {}

function M.setup()
    require("iron.core").setup(iron_options)
end

return M
