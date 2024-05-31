call plug#begin('~/.config/nvim/plugged')

" OneDark
Plug 'joshdick/onedark.vim'

"NeoSolarized
Plug 'iCyMind/NeoSolarized'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" TS
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP Support
Plug 'neovim/nvim-lspconfig'             
Plug 'williamboman/mason.nvim'          
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion Engine
Plug 'hrsh7th/nvim-cmp'         
Plug 'hrsh7th/cmp-nvim-lsp'    
Plug 'hrsh7th/cmp-buffer'      
Plug 'hrsh7th/cmp-path'        
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lua'    

"  Snippets
Plug 'L3MON4D3/LuaSnip'             
Plug 'rafamadriz/friendly-snippets'


" LSP
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}

" Transparent Background w/ Picom
Plug 'xiyaowong/transparent.nvim'
set termguicolors

call plug#end()
lua require('init')
lua require("nano-theme").load()








