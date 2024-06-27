local M = {}

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

function M.setup_leaders(map_leader, local_map_leader)
    vim.g.mapleader = map_leader or ","
    vim.g.maplocalleader = local_map_leader or ","
end

function M.setup_lsp_keymap(bufnr)
    local keymap = {
        {
            key = "K",
            action = vim.lsp.buf.hover,
            options = {
                buffer = bufnr,
                desc = "hover [K]noledge with LSP",
            },
        },
        {
            key = "gd",
            action = vim.lsp.buf.definition,
            options = {
                buffer = bufnr,
                desc = "[g]o to [d]efinition with LSP",
            },
        },
        {
            key = "gy",
            action = vim.lsp.buf.type_definition,
            options = {
                buffer = bufnr,
                desc = "[g]o to t[y]pe definition with LSP",
            },
        },
        {
            key = "gi",
            action = vim.lsp.buf.implementation,
            options = {
                buffer = bufnr,
                desc = "[g]o to [i]mplementation with LSP",
            },
        },
        {
            key = "<leader>cr",
            action = vim.lsp.buf.rename,
            options = {
                buffer = bufnr,
                desc = "[r]ename variable with LSP",
            },
        },
        {
            key = "<leader>cf",
            action = vim.lsp.buf.format,
            options = {
                buffer = bufnr,
                desc = "[f]format document with LSP",
            },
        },
        {
            key = "<leader>dj",
            action = vim.diagnostic.goto_next,
            options = {
                buffer = bufnr,
                desc = "Go to next [d]iagnostic with LSP",
            },
        },
        {
            key = "<leader>dk",
            action = vim.diagnostic.goto_prev,
            options = {
                buffer = bufnr,
                desc = "Go to previous [d]iagnostic with LSP",
            },
        },
    }

    for _, bind in ipairs(keymap) do
        vim.keymap.set("n", bind.key, bind.action, bind.options)
    end
end

function M.setup_telescope_keymap()
    local keymap = {
        {
            key = "<leader>?",
            action = "oldfiles",
            desc = "[?] Find recently opened files",
        },
        {
            key = "<leader>sb",
            action = "buffers",
            desc = "[ ] Find existing buffers",
        },
        {
            key = "<leader>/",
            action = "current_buffer_fuzzy_find",
            desc = "[/] Fuzzily search in current buffer]",
        },
        {
            key = "<leader>sf",
            action = "find_files",
            desc = "[s]earch [f]iles",
        },
        {
            key = "<leader>sh",
            action = "help_tags",
            desc = "[s]earch [h]elp",
        },
        {
            key = "<leader>sw",
            action = "grep_string",
            desc = "[s]earch current [w]ord",
        },
        {
            key = "<leader>sg",
            action = "live_grep",
            desc = "[s]earch by [g]rep",
        },
        {
            key = "<leader>sd",
            action = "diagnostics",
            desc = "[s]earch [d]iagnotics",
        },
        {
            key = "<leader>sk",
            action = "keymaps",
            desc = "[s]earch [k]eymaps",
        },
    }

    local builtin = require("telescope.builtin")
    for _, bind in ipairs(keymap) do
        vim.keymap.set("n", bind.key, builtin[bind.action], { desc = bind.desc })
    end
end

return M
