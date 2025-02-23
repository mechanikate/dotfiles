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
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 20,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(data)
    local api = require("nvim-tree.api")
    api.tree.open()
  end,
})

