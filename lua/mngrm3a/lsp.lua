vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data and ev.data.client_id or -1)
        if not client then return end
        require("mngrm3a.keymap").lsp(ev.buf)

        -- Enable completion if supported
        -- if client.supports_method(client, "textDocument/completion") then
        --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        -- end

        -- Set up format on save if supported
        if client.supports_method(client, "textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf })
                end,
            })
        end

        -- Set up buffer-local symbol highlighting if supported
        if client.supports_method(client, "textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("highlight_symbol", { clear = false })

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
    end,
})
