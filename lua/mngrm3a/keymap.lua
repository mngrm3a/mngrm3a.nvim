local M = {}

local function mk_map(buffer)
    return function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs,
            { desc = desc, buffer = buffer, silent = true, noremap = true })
    end
end

function M.mk_cmp_keymap(cmp, cmp_select)
    -- return {
    -- 	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    -- 	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    -- 	['<C-y>'] = cmp.mapping.confirm({ select = true }),
    -- 	["<C-Space>"] = cmp.mapping.complete()
    -- }
    -- TODO: figure out what config is most useful and clean this up
    -- in case cmp_select is not need, delete the local variable in the
    -- completion module
    return {
        ['<C-p>'] = cmp.mapping.scroll_docs(-4),
        ['<C-n>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert
        })
    }
end

function M.setup_gitsigns_keymap(buffer)
    local m = mk_map(buffer)
    local gs = require('gitsigns')

    m("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gs.nav_hunk('next')
            end
        end,
        "Go to next hunk")
    m("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gs.nav_hunk('prev')
            end
        end,
        "Go to previos hunk")

    m("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
    m("v", "<leader>hs",
        function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        "Stage hunk")
    m("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
    m("v", "<leader>hr",
        function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        "Reset hunk")
    m("n", "<leader>hu", gs.undo_stage_hunk, "Unstage hunk")
    m("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

    m("n", "<leader>hx", gs.toggle_deleted, "Toggle deleted hunks")
    m("n", "<leader>hw", gs.toggle_word_diff, "Toggle word diff")

    -- INFO: https://github.com/lewis6991/gitsigns.nvim/blob/6b1a14eabcebbcca1b9e9163a26b2f8371364cb7/lua/gitsigns/actions.lua#L1317
    m("n", "<leader>hv", function() gs.setqflist(0) end,
        "Show all hunks in current buffer")
    m("n", "<leader>hV", function() gs.setqflist("all") end,
        "Show all hunks in working directory")

    m("n", "<leader>hb", function() gs.blame_line { full = true } end,
        "Show blame")
    m("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle linewise blame")

    m("n", "<leader>hd", gs.diffthis, "Show diff for current hunk")
    m("n", "<leader>hD", function() gs.diffthis("~") end,
        "Show diff for current buffer")

    m("n", "<leader>hS", gs.stage_buffer, "Stage all hunks")
    m("n", "<leader>hR", gs.reset_buffer, "Reset all hunks")

    m({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

function M.setup_lsp_keymap(buffer)
    local m = mk_map(buffer)

    local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end

    m("n", "<leader>xl", ":LspLog<CR>", "Open LSP log")

    m("n", "K", vim.lsp.buf.hover, "Hover knowledge")
    m("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
    m("n", "<leader>gt", vim.lsp.buf.type_definition, "Go to type definition")
    m("n", "<leader>gi", vim.lsp.buf.implementation, "Go to implementation")
    m("n", "<leader>cd",
        function() vim.diagnostic.open_float({ severity_sort = true }) end,
        "Rename identifier")
    m("n", "<leader>cr", vim.lsp.buf.rename, "Rename identifier")
    m("n", "<leader>cf", vim.lsp.buf.format, "Format buffer")
    m("n", "<leader>cl", vim.lsp.codelens.run, "Run codelens")
    m("n", "<leader>ca", vim.lsp.buf.code_action, "Show code actions")
    m("n", "<leader>ci", vim.lsp.buf.signature_help, "Show signature help")
    m("n", "<leader>ch", toggle_inlay_hints, "Toggle inlay hints")
end

--------------------------------------------------------------------------------
-- section: setup
--------------------------------------------------------------------------------
function M.setup(map_leader, local_map_leader)
    local m = mk_map()

    -- leaders
    vim.g.mapleader = map_leader or ","
    vim.g.maplocalleader = local_map_leader or ","

    -- telescope
    local builtin = require("telescope.builtin")
    m("n", "<leader>?", builtin.oldfiles, "Find recently opened files")
    m("n", "<leader>sb", builtin.buffers, "Find existing buffers")
    m("n", "<leader>/", builtin.current_buffer_fuzzy_find, "Fuzzily search in current buffer")
    m("n", "<leader>sf", builtin.find_files, "Search files")
    m("n", "<leader>sh", builtin.help_tags, "Search help")
    m("n", "<leader>sw", builtin.grep_string, "Search current word")
    m("n", "<leader>sW", builtin.live_grep, "Search with grep")
    m("n", "<leader>sd", builtin.diagnostics, "Search diagnotics")
    m("n", "<leader>sk", builtin.keymaps, "Search keymaps")
    m("n", "<leader>sj", builtin.jumplist, "Search jumplist")
    m("n", "<leader>sm", builtin.marks, "Search marks")
    m("n", "<leader>sq", builtin.quickfix, "Search quickfixes")
    m("n", "<leader>sg", builtin.git_branches, "Search branches")
    m("n", "<leader>sc", builtin.git_commits, "Search commits")

    -- iron
    local ic = require("iron.core")
    local im = require("iron.marks")
    local r = require("mngrm3a.repl")

    m('n', '<leader>rs', '<CMD>IronRepl<CR>', "Start REPL")
    m('n', '<leader>rS', '<CMD>IronRestart<CR>', "Restart REPL")
    m('n', '<leader>rq', '<CMD>IronHide<CR>', "Hide REPL")
    m('n', '<leader>rQ', ic.close_repl, "Close REPL")
    m('n', '<leader>rg', '<CMD>IronFocus<CR>', "Focus REPL")

    m('n', '<leader>rc', function() ic.run_motion("send_motion") end, "Send motion")
    m('v', '<leader>rc', ic.visual_send, "Send motion")
    m('n', '<leader>rf', ic.send_file, "Send file")
    m('n', '<leader>rl', ic.send_line, "Send line")
    m('n', '<leader>rp', ic.send_paragraph, "Send paragraph")
    m('n', '<leader>ru', ic.send_until_cursor, "Send until cursor")
    m('n', '<leader>rm', ic.send_mark, "Send mark")
    m('n', '<leader>rmc', function() ic.run_motion("mark_motion") end, "Send mark")
    m('v', '<leader>rmc', ic.mark_visual, "Send mark")
    m('n', '<leader>rmd', im.drop_last, "Remove mark")

    local function iron_send_special(code)
        return function() ic.send(nil, string.char(code)) end
    end

    m('n', '<leader>r<CR>', iron_send_special(13), "Send return")
    m('n', '<leader>ri', iron_send_special(03), "Send interrupt")
    m('n', '<leader>rx', iron_send_special(12), "Send interrupt")

    -- tools
    m("n", "<leader>tg", "<CMD>Neogit<CR>", "Open Neogit")
    m("n", "<leader>td", "<CMD>DiffviewOpen<CR>", "Open Diffview")
    m("n", "<leader>th", "<CMD>DiffviewFileHistory<CR>", "Show file history")
    m("n", "<leader>tu", "<CMD>UndotreeToggle<CR>", "Toggle Undotree")
    m("n", "<leader>te", "<CMD>Oil<CR>", "Show filemanager")

    -- buffers
    m("n", "<leader>z", "<CMD>bprevious<CR>", "Go to previous buffer")
    m("n", "<leader>Z", "<CMD>bfirst<CR>", "Go to first buffer")
    m("n", "<leader>x", "<CMD>bnext<CR>", "Go to next buffer")
    m("n", "<leader>X", "<CMD>blast<CR>", "Go to last buffer")

    -- movement
    m("n", "<C-d>", "<C-d>zz", "Scroll downwards")
    m("n", "<C-u>", "<C-u>zz", "Scroll upwards")
    m("n", "j", "jzz", "Scroll downwards")
    m("n", "k", "kzz", "Scroll upwards")

    -- lsp
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            M.setup_lsp_keymap(args.buf)
        end
    })
end

return M
