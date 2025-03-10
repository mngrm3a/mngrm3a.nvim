-- -----------------------------------------------------------------------------
-- section: highlight symbol under cursor
-- -----------------------------------------------------------------------------
local function setup_highlight_symbol(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil or not client.supports_method('textDocument/documentHighlight') then
        return
    end

    local group = vim.api.nvim_create_augroup('highlight_symbol', { clear = false })

    vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = group,
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = group,
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
    })
end

local function setup_highlight_symbol_autocmd()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'Setup highlight symbol',
        callback = setup_highlight_symbol,
    })
end

-- -----------------------------------------------------------------------------
-- section: autosave on close
-- -----------------------------------------------------------------------------
local fmt_group = vim.api.nvim_create_augroup('autoformat_cmds', { clear = true })

local function setup_autoformat(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
        return
    end

    vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = event.buf })

    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = event.buf,
        group = fmt_group,
        desc = 'Format current buffer',
        callback = function(e)
            vim.lsp.buf.format({
                bufnr = e.buf,
                async = false,
                timeout_ms = 10000,
            })
        end,
    })
end

local function setup_autoformat_autocmd()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'Setup format on save',
        callback = setup_autoformat,
    })
end

-- -----------------------------------------------------------------------------
-- section: setup
-- -----------------------------------------------------------------------------
local function with_capabilities(opts)
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    )

    return vim.tbl_deep_extend(
        "force",
        { capabilities = capabilities },
        opts
    )
end

local M = {}

function M.setup(log_level)
    log_level = log_level or vim.log.levels.DEBUG
    vim.lsp.set_log_level(log_level)

    setup_autoformat_autocmd()
    setup_highlight_symbol_autocmd()

    require("mngrm3a.lsp.shell")(with_capabilities)
    require("mngrm3a.lsp.lua")(with_capabilities)
    require("mngrm3a.lsp.nix")(with_capabilities)
    require("mngrm3a.lsp.haskell")(with_capabilities)
    require("mngrm3a.lsp.go")(with_capabilities)
end

return M
