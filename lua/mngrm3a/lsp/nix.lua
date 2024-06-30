return function(lspconfig, capabilities)
    lspconfig.nil_ls.setup({
        capabilities = capabilities,
        settings = {
            ["nil"] = {
                formatting = {
                    command = { "nixfmt" }
                }
            }
        }
    })
end
