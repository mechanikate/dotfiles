require("mason").setup()
local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()


vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = true
})
