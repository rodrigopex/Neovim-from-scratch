local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

lspconfig.vimls.setup {
    on_attach = require("aerial").on_attach,
}

lspconfig.robotframework_ls.setup{

}

local on_attach = function(client)
    require 'completion'.on_attach(client)
end

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy"
                        },
                        assist = {
                            importGranularity = "module",
                            importPrefix = "self",
                        },
                        cargo = {
                            all_features = true,
                            loadOutDirsFromCheck = true
                        },
                        procMacro = {
                            enable = true
                        },
                        inlayHints = {
                            chainingHints = true,
                            closureReturnTypeHints = true,
                            reborrowHints = true,
                            lifetimeElisionHints = {
                                enable = "never",
                                useParameterNames = true },

                        },
                    }
                }
            }
        }
    },
}
require('rust-tools').setup(opts)
require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
-- require "user.lsp.null-ls"
