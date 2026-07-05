return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-ui-select.nvim',
    },
    opts = {
        defaults = {
            layout_strategy = 'vertical',
            layout_config = { width = 0.95, height = 0.95 },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {}
            }
        }
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")
    end,
    keys = function()
        local tb = require("telescope.builtin")
        return {
            { '<leader>ff', tb.git_files,             desc = 'File (Git)' },
            {
                '<leader>fF',
                function() tb.find_files({ find_command = { "fd", "--type", "f", "--no-ignore" } }) end,
                desc = 'File (WD)'
            },
            { '<leader>fb', tb.buffers,               desc = 'Buffer (Open)' },
            { '<leader>fB', tb.oldfiles,              desc = 'Buffer (Recent)' },
            { '<leader>fw', tb.live_grep,             desc = 'String (Buffer)' },
            { '<leader>fW', tb.grep_string,           desc = 'String (WD)' },
            { '<leader>fd', tb.diagnostics,           desc = 'Diagnostic (Buffer)' },
            { '<leader>fg', tb.git_branches,          desc = 'Branch' },
            { '<leader>fG', tb.git_stash,             desc = 'Stash' },
            { '<leader>fs', tb.lsp_document_symbols,  desc = 'Symbols (Buffer)' },
            { '<leader>fS', tb.lsp_workspace_symbols, desc = 'Symbols (Workspace)' },
            { '<leader>fq', tb.quickfix,              desc = 'Quickfix' },
            { '<leader>fQ', tb.quickfixHistory,       desc = 'Quickfix (Recent)' },

            { '<leader>§r', tb.registers,             desc = 'Register' },
            { '<leader>§k', tb.keymaps,               desc = 'Keymap' },
            { '<leader>§m', tb.marks,                 desc = 'Mark' },
            { '<leader>§C', tb.command_history,       desc = 'Command History' },
        }
    end,
}
