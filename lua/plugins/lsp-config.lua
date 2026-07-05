vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data and ev.data.client_id or -1)
        if not client then return end

        local function map(mode, l, r, desc)
            local opts = { buffer = ev.buf, silent = true, desc = desc }
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>ld', vim.lsp.buf.definition, 'Definition')
        map('n', '<leader>lD', vim.lsp.buf.declaration, 'Declaration')
        map('n', '<leader>lt', vim.lsp.buf.type_definition, 'Type Definition')
        map('n', '<leader>li', vim.lsp.buf.implementation, 'Implementation')
        map('n', '<leader>lr', vim.lsp.buf.references, 'References')
        map('n', '<leader>ln', vim.lsp.buf.rename, 'Rename')
        map('n', '<leader>la', vim.lsp.buf.code_action, 'Code Action')
        map('n', '<leader>ls', vim.lsp.buf.signature_help, 'Signature Help')
        map('n', '<leader>le', vim.diagnostic.open_float, 'Show Diagnostics')
        map('n', '<leader>lq', vim.diagnostic.setloclist, 'Loclist Diagnostics')

        -- Enable document highlighting if supported (using object-oriented method syntax)
        if client:supports_method("textDocument/documentHighlight", ev.buf) then
            local group = vim.api.nvim_create_augroup("lsp_highlight", { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = group })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = group,
                buffer = ev.buf,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                group = group,
                buffer = ev.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- Enable CodeLens if supported
        if client:supports_method("textDocument/codeLens", ev.buf) then
            vim.lsp.codelens.enable(true, { bufnr = ev.buf })
            map("n", "<leader>ll", vim.lsp.codelens.run, "Run CodeLens")
        end
    end,
})

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable({
                "bashls",
                "nil_ls",

                "jsonls",
                "yamlls",

                "gopls",
                "basedpyright",
                "oxlint",
                "lua_ls",

                "html",
                "ts_ls",
                "cssls",
                "tailwindcss",
            })
        end,
    },
}

