-- Keymaps for LSP, Telescope, and GitSigns using WhichKey
local telescope = require('telescope.builtin')
local gitsigns = require('gitsigns')
local wk = require('which-key')
local M = {}

function M.default()
    wk.add({
        -- Telescope Group: <leader>f
        { '<leader>f',  group = 'Find' },
        { '<leader>ff', telescope.git_files, desc = 'File (Git)' },
        {
            '<leader>fF',
            function() telescope.find_files({ find_command = { "fd", "--type", "f", "--no-ignore" }, }) end,
            desc = 'File (WD)'
        },
        { '<leader>fb', telescope.buffers,                  desc = 'Buffer (Open)' },
        { '<leader>fB', telescope.oldfiles,                 desc = 'Buffer (Recent)' },
        { '<leader>fw', telescope.live_grep,                desc = 'String (Buffer)' },
        { '<leader>fW', telescope.grep_string,              desc = 'String (WD)' },
        { '<leader>fd', telescope.diagnostics,              desc = 'Diagnostic (Buffer)' },
        { '<leader>fg', telescope.git_branches,             desc = 'Branch' },
        { '<leader>fG', telescope.git_stash,                desc = 'Stash' },
        { '<leader>fq', telescope.quickfix,                 desc = 'Quickfix' },
        { '<leader>fQ', telescope.quickfixHistory,          desc = 'Quickfix (Recent)' },

        -- Vim Group: <leader>§
        { '<leader>f§', group = 'Vim' },
        { '<leader>§p', require('mngrm3a.ui').setThemeMode, desc = 'Toggle Ligh/Dark Mode' },
        { '<leader>§r', telescope.registers,                desc = 'Register' },
        { '<leader>§k', telescope.keymaps,                  desc = 'Keymap' },
        { '<leader>§m', telescope.marks,                    desc = 'Mark' },
        { '<leader>§C', telescope.command_history,          desc = 'Command History' },

        -- Tools Group: <leader>t
        { '<leader>t',  group = 'Tools' },
        { '<leader>tf', ':Oil<CR>',                         desc = 'File Manager' },
        { '<leader>tg', ':Neogit<CR>',                      desc = 'Neogit' },
        { '<leader>tl', ':Neogit log<CR>',                  desc = 'Neogit Log' },
        { '<leader>td', ':Neogit diff<CR>',                 desc = 'Neogit Diff' },
        { '<leader>tu', ':UndotreeShow<CR>',                desc = 'Undo Tree' },
        { '<leader>tm', ':NoiceTelescope<CR>',              desc = 'Messages' },

        -- Navigation
        { "<leader>b", expand = function() return require("which-key.extras").expand.buf() end, desc = "Select Buffer"
        },
        { '<C-t>',  group = 'Tabs' },
        { '<C-t>q', ':tabclose<CR>',    desc = 'Close' },
        { '<C-t>p', ':tabprevious<CR>', desc = 'Previous' },
        { '<C-t>P', ':tabfirst<CR>',    desc = 'First' },
        { '<C-t>n', ':tabnext<CR>',     desc = 'Next' },
        { '<C-t>n', ':tablast<CR>',     desc = 'Last' },

    })
end

function M.lsp(bufnr)
    wk.add({
        -- LSP Group: <leader>l
        group = "LSP",
        buffer = bufnr,
        { '<leader>l',  group = "LSP" },
        { '<leader>ld', vim.lsp.buf.definition,                             desc = 'Definition' },
        { '<leader>lD', vim.lsp.buf.declaration,                            desc = 'Declaration' },
        { '<leader>lt', vim.lsp.buf.type_definition,                        desc = 'Type Definition' },
        { '<leader>li', vim.lsp.buf.implementation,                         desc = 'Implementation' },
        { '<leader>lr', vim.lsp.buf.references,                             desc = 'References' },
        { '<leader>ln', vim.lsp.buf.rename,                                 desc = 'Rename' },
        { '<leader>la', vim.lsp.buf.code_action,                            desc = 'Code Action' },
        { '<leader>lf', function() vim.lsp.buf.format { async = true } end, desc = 'Format' },
        { '<leader>ls', vim.lsp.buf.signature_help,                         desc = 'Signature Help' },
        { '<leader>le', vim.diagnostic.open_float,                          desc = 'Show Diagnostics' },
        { '<leader>lq', vim.diagnostic.setloclist,                          desc = 'Loclist Diagnostics' },
    })
end

function M.gitsigns(bufnr)
    wk.add {
        -- Git Group: <leader>g
        group = "Git",
        buffer = bufnr,
        { '<leader>g',  group = 'Git' },
        -- Navigation
        { ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end, desc = 'Next Change' },
        { '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end, desc = 'Previous Change' },
        -- Action: Stage Hunk
        { '<leader>gs', gitsigns.stage_hunk, desc = 'Stage Hunk' },
        { '<leader>gs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, mode = "v", desc = 'Stage Hunk' },
        -- Action: Reset Hunk
        { '<leader>gr', gitsigns.reset_hunk,                                desc = "Reset Hunk" },
        { '<leader>gr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, mode = "v", desc = "Reset Hunk" },
        -- Action: Preview
        { '<leader>gp', gitsigns.preview_hunk,                              desc = 'Preview hunk' },
        { '<leader>gP', gitsigns.preview_hunk_inline,                       desc = 'Preview hunk inline' },
        -- Action: Buffers
        { '<leader>gS', gitsigns.stage_buffer,                              desc = 'Stage buffer' },
        { '<leader>gR', gitsigns.reset_buffer,                              desc = 'Reset buffer' },
        -- Action: Diff
        { '<leader>gd', gitsigns.diffthis,                                  desc = 'Diff this' },
        { '<leader>gD', function() gitsigns.diffthis('~') end,              desc = 'Diff this' },
        { '<leader>gw', gitsigns.toggle_word_diff,                          desc = 'Toggle word diff' },
        -- Action: Quickfix List
        { '<leader>gq', gitsigns.setsqlist,                                 desc = 'Quickfix list' },
        { '<leader>gQ', function() gitsigns.setsqlist('all') end,           desc = 'Quickfix list' },
        -- Action: Blame
        { '<leader>gb', function() gitsigns.blame_line { full = true } end, desc = 'Blame line' },
        { '<leader>gB', gitsigns.toggle_current_line_blame,                 desc = 'Toggle blame line' },
        -- Action: Toggle Signs
        { '<leader>gt', gitsigns.toggle_signs,                              desc = 'Toggle signs' },
        -- Text object
        { 'ih',         gitsigns.select_hunk,                               mode = { 'o', 'x' },         desc = 'Text object' },
    }
end

return M
