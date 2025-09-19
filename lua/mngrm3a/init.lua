local M = {}

function M.setup()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    require("mngrm3a.options")
    require('mngrm3a.ui')
    local keymap = require('mngrm3a.keymap')
    keymap.default()

    -- -------------------------------------------------------------------------
    -- treesitter
    -- -------------------------------------------------------------------------
    require('nvim-treesitter.configs').setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        },
    })

    -- -------------------------------------------------------------------------
    -- completions
    -- -------------------------------------------------------------------------
    local blink = require('blink.cmp')
    local blink_select_prev = function() blink.select_prev({ auto_insert = false, on_ghost_text = false }) end
    local blink_select_next = function() blink.select_next({ auto_insert = false, on_ghost_text = false }) end
    blink.setup(
        {
            -- TODO:
            -- * disable completions for comments
            -- * enable spellchecking code actions
            keymap = {
                preset = 'super-tab',
                ['<C-p>'] = { blink_select_prev, 'fallback_to_mappings' },
                ['<C-n>'] = { blink_select_next, 'fallback_to_mappings' },
                ['<Up>'] = { blink_select_prev, 'fallback_to_mappings' },
                ['<Down>'] = { blink_select_next, 'fallback_to_mappings' },
                ['<CR>'] = { 'accept', 'fallback' },
            },
            cmdline = {
                completion = { menu = { auto_show = true } },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            completion = {
                keyword = { range = 'full' },
                accept = { auto_brackets = { enabled = false }, },
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = true },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            signature = { enabled = true }
        }
    )

    -- -------------------------------------------------------------------------
    -- lsp
    -- -------------------------------------------------------------------------
    require("mngrm3a.lsp")
    for _, server in ipairs({
        -- general
        'lua_ls',
        'gopls',
        'pyright',
        'java_language_server',
        -- web
        'htmx',
        'html',
        'eslint',
        'ts_ls',
        'cssls',
        'tailwindcss',
        -- other
        'nil_ls',
        'jsonls',
        'yamlls',
    }) do
        vim.lsp.enable(server)
    end

    -- -------------------------------------------------------------------------
    -- vcs
    -- -------------------------------------------------------------------------
    require("gitsigns").setup({ on_attach = keymap.gitsigns })
    require("neogit").setup()
    require("diffview").setup({
        view = {
            merge_tool = {
                layout = "diff3_mixed"
            }
        }
    })

    -- -------------------------------------------------------------------------
    -- telescope
    -- -------------------------------------------------------------------------
    require("telescope").setup({
        defaults = {
            layout_strategy = 'vertical',
            layout_config = { width = 0.95, height = 0.95 },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                }
            }
        }
    })
    require('telescope').load_extension("fzf")
    require("telescope").load_extension("ui-select")

    -- -------------------------------------------------------------------------
    -- utils
    -- -------------------------------------------------------------------------
    require("oil").setup()
    require("which-key").setup({ preset = "helix" })
    require('todo-comments').setup({
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS):]],
        }
    })
end

return M
