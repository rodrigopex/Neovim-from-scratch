local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

lspconfig.vimls.setup {
    on_attach = require("aerial").on_attach,
}

require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
-- require "user.lsp.null-ls"
