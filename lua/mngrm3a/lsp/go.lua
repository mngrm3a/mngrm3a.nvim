return function(with_capabilities)
    return require("lspconfig").gopls.setup(with_capabilities {})
end
