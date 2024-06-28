local M = {}


local function m(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, type(opts) == "string" and { desc = opts } or opts)
end

local function ms(mo, l, r, d)
    m(mo, l, r, { desc = d, silent = true })
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

function M.mk_gitsigns_keymap(bufnr)
    local gs = require('gitsigns')

    local function m_(mo, l, r, d)
        m(mo, l, r, { desc = d, buffer = bufnr })
    end

    m_("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gs.nav_hunk('next')
            end
        end,
        "Go to next hunk")
    m_("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gs.nav_hunk('prev')
            end
        end,
        "Go to previos hunk")

    m_("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
    m_("v", "<leader>hs",
        function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        "Stage hunk")
    m_("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
    m_("v", "<leader>hr",
        function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        "Reset hunk")
    m_("n", "<leader>hu", gs.undo_stage_hunk, "Unstage hunk")
    m_("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
    m_("n", "<leader>hx", gs.toggle_deleted, "Toggle deleted hunks")

    m_("n", "<leader>hb", function() gs.blame_line { full = true } end,
        "Show blame")
    m_("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle linewise blame")

    m_("n", "<leader>hd", function() gs.diffthis({ split = "rightbelow" }) end, "Show diff for current hunk")
    m_("n", "<leader>hD", function() gs.diffthis("~", { split = "rightbelow" }) end,
        "Show diff for current buffer")

    m_("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
    m_("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

    m_({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

local function setup_lsp_keymap()
    m("n", "K", vim.lsp.buf.hover, "Hover knowledge")
    m("n", "<leader>jd", vim.lsp.buf.definition, "Jump to definition")
    m("n", "<leader>jt", vim.lsp.buf.type_definition, "Jump to type definition")
    m("n", "<leader>ji", vim.lsp.buf.implementation, "Jump to implementation")
    m("n", "<leader>ar", vim.lsp.buf.rename, "Rename identifier")
    m("n", "<leader>af", vim.lsp.buf.format, "Format document")
    m("n", "<leader>dj", vim.diagnostic.goto_next, "Go to next diagnostic")
    m("n", "<leader>dk", vim.diagnostic.goto_prev, "Go to previous diagnostic")
end

local function setup_telescope_keymap()
    local builtin = require("telescope.builtin")
    m("n", "<leader>?", builtin.oldfiles, "Find recently opened files")
    m("n", "<leader>sb", builtin.buffers, "Find existing buffers")
    m("n", "<leader>/", builtin.current_buffer_fuzzy_find, "Fuzzily search in current buffer")
    m("n", "<leader>sf", builtin.find_files, "Search files")
    m("n", "<leader>sh", builtin.help_tags, "Search help")
    m("n", "<leader>sw", builtin.grep_string, "Search current word")
    m("n", "<leader>sg", builtin.live_grep, "Search with grep")
    m("n", "<leader>sd", builtin.diagnostics, "Search diagnotics")
    m("n", "<leader>sk", builtin.keymaps, "Search keymaps")
end

local function setup_vcs_tool_keymap()
    ms("n", "<leader>xs", ":Neogit<CR>", "Open Neogit")
    ms("n", "<leader>xd", ":DiffviewOpen<CR>", "Open Diffview")
    ms("n", "<leader>xh", ":DiffviewFileHistory<CR>", "Show file history")
end

local function setup_tab_keymap()
    for i = 1, 9, 1 do
        m(
            "n",
            string.format("<leader>%d", i),
            string.format("%dgt", i),
            string.format("Go to tab #%d", i)
        )
    end
    m("n", "<leader>tc", ":tabclose<CR>", "Close tab")
    m("n", "<leader>tn", ":tabNext", "Go to next tab")
    m("n", "<leader>tn", ":tabprevious", "Go to previous tab")
end

--------------------------------------------------------------------------------
-- section: setup
--------------------------------------------------------------------------------
function M.setup(map_leader, local_map_leader)
    vim.g.mapleader = map_leader or ","
    vim.g.maplocalleader = local_map_leader or ","

    setup_lsp_keymap()
    setup_telescope_keymap()
    setup_vcs_tool_keymap()
    setup_tab_keymap()
end

return M
