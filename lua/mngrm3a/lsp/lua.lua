return function(with_capabilities)
    require("lspconfig").lua_ls.setup(with_capabilities {})
end
