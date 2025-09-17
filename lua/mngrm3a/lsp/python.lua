return function(with_capabilities)
    return require("lspconfig").pyright.setup(with_capabilities {})
end
