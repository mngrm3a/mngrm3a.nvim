local function next_hunk_or_change()
    local gitsigns = require("gitsigns")
    if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
    else
        gitsigns.nav_hunk('next')
    end
end

local function prev_hunk_or_change()
    local gitsigns = require("gitsigns")
    if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
    else
        gitsigns.nav_hunk('prev')
    end
end

return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map('n', ']c', next_hunk_or_change, { desc = 'Next Change' })
                map('n', '[c', prev_hunk_or_change, { desc = 'Previous Change' })
                map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
                map('v', '<leader>gs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                    { desc = 'Stage Hunk' })

                map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset Hunk" })
                map('v', '<leader>gr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
                    { desc = "Reset Hunk" })

                map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
                map('n', '<leader>gP', gitsigns.preview_hunk_inline, { desc = 'Preview hunk inline' })
                map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
                map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
                map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff this' })
                map('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = 'Diff this' })
                map('n', '<leader>gw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })
                map('n', '<leader>gq', gitsigns.setqflist, { desc = 'Quickfix list' })
                map('n', '<leader>gQ', function() gitsigns.setqflist('all') end, { desc = 'Quickfix list (all)' })
                map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, { desc = 'Blame line' })
                map('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame line' })
                map('n', '<leader>gt', gitsigns.toggle_signs, { desc = 'Toggle signs' })

                -- Text object
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Text object' })
            end
        }
    },
    {
        "sindrets/diffview.nvim",
        opts = {
            view = {
                merge_tool = {
                    layout = "diff3_mixed"
                }
            }
        }
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        keys = {
            { '<leader>tg', '<cmd>Neogit<CR>',      desc = 'Neogit' },
            { '<leader>tl', '<cmd>Neogit log<CR>',  desc = 'Neogit Log' },
            { '<leader>td', '<cmd>Neogit diff<CR>', desc = 'Neogit Diff' },
        }
    }
}
