call plug#begin('~/.config/nvim/plugged')
" Put all your `Plug <x>/<y>` statements here!
" Let's add Mason for LSP
Plug 'williamboman/mason.nvim' 
" and TreeSitter for highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP Support
Plug 'neovim/nvim-lspconfig'               
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}
Plug 'L3MON4D3/LuaSnip'             
Plug 'rafamadriz/friendly-snippets'
" Autocompletion Engine
Plug 'hrsh7th/nvim-cmp'         
Plug 'hrsh7th/cmp-nvim-lsp'    
Plug 'hrsh7th/cmp-buffer'      
Plug 'hrsh7th/cmp-path'        
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lua'
" File Explorer
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'xiyaowong/transparent.nvim'
call plug#end()
" Put all your `lua require('<xyz>') statements here! Make sure to include the following too:
lua require('init')
lua require("nano-theme").load()
