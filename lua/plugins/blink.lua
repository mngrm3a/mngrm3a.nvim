local function select_prev_candidate()
    require("blink.cmp").select_prev({ auto_insert = false, on_ghost_text = false })
end

local function select_next_candidate()
    require("blink.cmp").select_next({ auto_insert = false, on_ghost_text = false })
end

return {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
        keymap = {
            -- see: https://cmp.saghen.dev/configuration/keymap.html#presets
            preset = 'super-tab',
            ['<C-p>'] = { select_prev_candidate, 'fallback_to_mappings' },
            ['<C-n>'] = { select_next_candidate, 'fallback_to_mappings' },
            ['<Up>'] = { select_prev_candidate, 'fallback_to_mappings' },
            ['<Down>'] = { select_next_candidate, 'fallback_to_mappings' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },
            ['<CR>'] = { 'select_and_accept', 'fallback' },
        },
        cmdline = {
            completion = { menu = { auto_show = true } },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        completion = {
            keyword = { range = 'full' },
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            ghost_text = { enabled = false },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        signature = { enabled = true }
    },
}
