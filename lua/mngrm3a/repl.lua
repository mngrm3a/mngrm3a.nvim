local iron_options = {
    config = {
        scratch_repl = true,
        repl_definition = {
            sh = { command = { "zsh" } },
            haskell = {
                command = function(meta)
                    return {
                        "cabal",
                        "repl",
                        vim.api.nvim_buf_get_name(meta.current_bufnr)
                    }
                end
            }
        },
        repl_open_cmd = require("iron.view").split.horizontal.botright(0.25, {
            relativenumber = false,
            signcolumn = "no"
        })
        -- repl_open_cmd = require("iron.view").bottom(.025)
    },
    highlight = {
        italic = true
    },
    ignore_blank_lines = true,
}

local M = {}

function M.setup()
    require("iron.core").setup(iron_options)
end

return M
