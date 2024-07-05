return function(with_capabilities)
    return require('lspconfig').bashls.setup(with_capabilities {
        -- filetypes = { "zsh", 'sh' }
    })
end
