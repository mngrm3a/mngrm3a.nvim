return function(with_capabilities)
    require("lspconfig").nil_ls.setup(with_capabilities {
        settings = {
            ["nil"] = {
                formatting = {
                    command = { "nixfmt" }
                }
            }
        }
    })
end
