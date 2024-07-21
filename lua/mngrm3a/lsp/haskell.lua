local hls_default_settings = {
    ["cabalFormattingProvider"] = "cabal-gild",
    ["checkParents"] = "CheckOnSave",
    ["checkProject"] = true,
    ["formattingProvider"] = "ormolu",
    ["maxCompletions"] = 40,
    ["plugin"] = {
        ["alternateNumberFormat"] = {
            ["globalOn"] = true
        },
        ["cabal"] = {
            ["codeActionsOn"] = true,
            ["completionOn"] = true,
            ["diagnosticsOn"] = true
        },
        ["cabal-fmt"] = {
            ["config"] = {
                ["path"] = "cabal-fmt"
            }
        },
        ["cabal-gild"] = {
            ["config"] = {
                ["path"] = "cabal-gild"
            }
        },
        ["callHierarchy"] = {
            ["globalOn"] = true
        },
        ["changeTypeSignature"] = {
            ["globalOn"] = true
        },
        ["class"] = {
            ["codeActionsOn"] = true,
            ["codeLensOn"] = true
        },
        ["eval"] = {
            ["config"] = {
                ["diff"] = true,
                ["exception"] = false
            },
            ["globalOn"] = true
        },
        ["explicit-fields"] = {
            ["globalOn"] = true
        },
        ["explicit-fixity"] = {
            ["globalOn"] = true
        },
        ["fourmolu"] = {
            ["config"] = {
                ["external"] = false,
                ["path"] = "fourmolu"
            }
        },
        ["gadt"] = {
            ["globalOn"] = true
        },
        ["ghcide-code-actions-bindings"] = {
            ["globalOn"] = true
        },
        ["ghcide-code-actions-fill-holes"] = {
            ["globalOn"] = true
        },
        ["ghcide-code-actions-imports-exports"] = {
            ["globalOn"] = true
        },
        ["ghcide-code-actions-type-signatures"] = {
            ["globalOn"] = true
        },
        ["ghcide-completions"] = {
            ["config"] = {
                ["autoExtendOn"] = true,
                ["snippetsOn"] = true
            },
            ["globalOn"] = true
        },
        ["ghcide-hover-and-symbols"] = {
            ["hoverOn"] = true,
            ["symbolsOn"] = true
        },
        ["ghcide-type-lenses"] = {
            ["config"] = {
                ["mode"] = "always"
            },
            ["globalOn"] = true
        },
        ["hlint"] = {
            ["codeActionsOn"] = true,
            ["config"] = {
                ["flags"] = {}
            },
            ["diagnosticsOn"] = true
        },
        ["importLens"] = {
            ["codeActionsOn"] = true,
            ["codeLensOn"] = true
        },
        ["moduleName"] = {
            ["globalOn"] = true
        },
        ["ormolu"] = {
            ["config"] = {
                ["external"] = false
            }
        },
        ["overloaded-record-dot"] = {
            ["globalOn"] = true
        },
        ["pragmas-completion"] = {
            ["globalOn"] = true
        },
        ["pragmas-disable"] = {
            ["globalOn"] = true
        },
        ["pragmas-suggest"] = {
            ["globalOn"] = true
        },
        ["qualifyImportedNames"] = {
            ["globalOn"] = true
        },
        ["rename"] = {
            ["config"] = {
                ["crossModule"] = true
            },
            ["globalOn"] = true
        },
        ["retrie"] = {
            ["globalOn"] = true
        },
        ["semanticTokens"] = {
            ["config"] = {
                ["classMethodToken"] = "method",
                ["classToken"] = "class",
                ["dataConstructorToken"] = "enumMember",
                ["functionToken"] = "function",
                ["moduleToken"] = "namespace",
                ["operatorToken"] = "operator",
                ["patternSynonymToken"] = "macro",
                ["recordFieldToken"] = "property",
                ["typeConstructorToken"] = "enum",
                ["typeFamilyToken"] = "interface",
                ["typeSynonymToken"] = "type",
                ["typeVariableToken"] = "typeParameter",
                ["variableToken"] = "variable"
            },
            ["globalOn"] = true
        },
        ["splice"] = {
            ["globalOn"] = true
        },
        ["stan"] = {
            ["globalOn"] = true
        }
    },
    ["sessionLoading"] = "singleComponent"
}

-- INFO: https://github.com/mrcjkb/haskell-tools.nvim/blob/56a4e572e9d8ad300e03a5d8fcc17b8cf679ad17/lua/haskell-tools/lsp/init.lua#L21
local function on_init_codelens_handler(client, _)
    local buffers = vim.lsp.get_buffers_by_client_id(client.id)

    if buffers and #buffers then
        vim.api.nvim_create_autocmd("VimLeavePre", {
            group = vim.api.nvim_create_augroup(string.format("hls-clean-exit-%s", client.id), { clear = true }),
            buffer = buffers[1],
            callback = function()
                vim.lsp.stop_client(client, false)
            end
        })
    end
end

-- INFO: https://github.com/mrcjkb/haskell-tools.nvim/blob/56a4e572e9d8ad300e03a5d8fcc17b8cf679ad17/lua/haskell-tools/lsp/init.lua#L156
local function on_attach_codelens_handler(client, buffer)
    if client and client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "TextChanged" }, {
            buffer = buffer,
            callback = function()
                vim.schedule(vim.lsp.codelens.refresh)
            end
        })
        vim.schedule(vim.lsp.codelens.refresh)
    end
end

local function setup_haskell_lsp(with_capabilities, log_level)
    require("lspconfig").hls.setup(with_capabilities {
        on_attach = function(client, buffer)
            vim.bo.tabstop = 2
            vim.bo.softtabstop = 2
            vim.bo.shiftwidth = 2
            on_attach_codelens_handler(client, buffer)
        end,
        on_init = on_init_codelens_handler,
        settings = { haskell = hls_default_settings }
    })
end

return setup_haskell_lsp
