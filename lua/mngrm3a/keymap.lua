local M = {}


local function m(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, type(opts) == "string" and { desc = opts } or opts)
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

function M.setup_gitsigns_keymap(bufnr)
    local gs = require('gitsigns')

    local function o(desc)
        return { desc = desc, buffer = bufnr }
    end

    m("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gs.nav_hunk('next')
            end
        end,
        o("Go to next hunk"))
    m("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gs.nav_hunk('prev')
            end
        end,
        o("Go to previos hunk"))

    m("n", "<leader>hs", gs.stage_hunk, o("Stage hunk"))
    m("v", "<leader>hs",
        function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        o("Stage hunk"))
    m("n", "<leader>hr", gs.reset_hunk, o("Reset hunk"))
    m("v", "<leader>hr",
        function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        o("Reset hunk"))
    m("n", "<leader>hu", gs.undo_stage_hunk, o("Unstage hunk"))
    m("n", "<leader>hp", gs.preview_hunk, o("Preview hunk"))

    m("n", "<leader>hx", gs.toggle_deleted, o("Toggle deleted hunks"))
    m("n", "<leader>hw", gs.toggle_word_diff, o("Toggle word diff"))

    -- INFO: https://github.com/lewis6991/gitsigns.nvim/blob/6b1a14eabcebbcca1b9e9163a26b2f8371364cb7/lua/gitsigns/actions.lua#L1317
    m("n", "<leader>hv", function() gs.setqflist(0) end,
        o("Show all hunks in current buffer"))
    m("n", "<leader>hV", function() gs.setqflist("all") end,
        o("Show all hunks in working directory"))

    m("n", "<leader>hb", function() gs.blame_line { full = true } end,
        o("Show blame"))
    m("n", "<leader>hB", gs.toggle_current_line_blame, o("Toggle linewise blame"))

    m("n", "<leader>hd", gs.diffthis, o("Show diff for current hunk"))
    m("n", "<leader>hD", function() gs.diffthis("~") end,
        o("Show diff for current buffer"))

    m("n", "<leader>hS", gs.stage_buffer, o("Stage all hunks"))
    m("n", "<leader>hR", gs.reset_buffer, o("Reset all hunks"))

    m({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

function M.setup_lsp_keymap(bufnr)
    local function o(desc)
        return { desc = desc, buffer = bufnr }
    end

    local function toggle_inlay_hints()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end

    m("n", "K", vim.lsp.buf.hover, o("Hover knowledge"))
    m("n", "<leader>gd", vim.lsp.buf.definition, o("Go to definition"))
    m("n", "<leader>gt", vim.lsp.buf.type_definition, o("Go to type definition"))
    m("n", "<leader>gi", vim.lsp.buf.implementation, o("Go to implementation"))
    m("n", "<leader>gn", vim.diagnostic.goto_next, o("Go to next diagnostic"))
    m("n", "<leader>gp", vim.diagnostic.goto_prev, o("Go to previous diagnostic"))

    m("n", "<leader>cr", vim.lsp.buf.rename, o("Rename identifier"))
    m("n", "<leader>cf", vim.lsp.buf.format, o("Format buffer"))
    m("n", "<leader>cl", vim.lsp.codelens.run, o("Run codelens"))
    m("n", "<leader>ca", vim.lsp.buf.code_action, o("Show code actions"))
    m("n", "<leader>ci", vim.lsp.buf.signature_help, o("Show signature help"))
    m("n", "<leader>ch", toggle_inlay_hints, o("Show signature help"))
end

function M.setup_telescope_keymap()
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
end

function M.setup_vcs_tool_keymap()
    local function o(desc)
        return { desc = desc, silent = true, noremap = true }
    end

    m("n", "<leader>xg", ":Neogit<CR>", o("Open Neogit"))
    m("n", "<leader>xd", ":DiffviewOpen<CR>", o("Open Diffview"))
    m("n", "<leader>xh", ":DiffviewFileHistory<CR>", o("Show file history"))
    m("n", "<leader>xu", ":UndotreeToggle<CR>", o("Toggle Undotree"))
    m("n", "<leader>xe", ":30Sexplore!<CR>", o("Show Netrw"))
end

--------------------------------------------------------------------------------
-- section: setup
--------------------------------------------------------------------------------
function M.setup(map_leader, local_map_leader)
    vim.g.mapleader = map_leader or ","
    vim.g.maplocalleader = local_map_leader or ","

    M.setup_telescope_keymap()
    M.setup_vcs_tool_keymap()

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            M.setup_lsp_keymap(args.buf)
        end
    })
end

return M
