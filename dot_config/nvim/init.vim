"-------- General Configuration
set noswapfile			            " no swap file
syntax enable			            " enable syntax
filetype plugin indent on	
set mouse=a			                " enable mouse
set updatetime=30		            " time before updates
set number
set relativenumber
set cul
set history=1000
set linebreak
set spell
set smartcase ignorecase incsearch	" searching and highlighting
set foldmethod=indent foldlevel=2
set foldcolumn=2
set foldlevelstart=99 foldopen+=jump
set nofoldenable
set clipboard=unnamedplus
set ts=4 sw=4 ai expandtab          " tabs should be spaces forever
set softtabstop=0
set breakindent
set breakindentopt=shift:4,min:40,sbr
set ruler
set wrap
set showcmd
set splitbelow splitright
set wildmenu wildmode=longest:full,full
set autowrite
set confirm
set noerrorbells
set undofile undodir=$HOME/.vim/undo
set autochdir
if has ("nvim")
    set termguicolors
endif

" - - -- --- PLUGINS
" install if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
    " Status Bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    if has('nvim')
       Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    endif
    
    " Commenting
    Plug 'preservim/nerdcommenter'

    " Theme
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

    " LSP
    Plug 'github/copilot.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'pechorin/any-jump.vim'
    if has('nvim')
        Plug 'folke/trouble.nvim'
    endif

    " Focus Helpers
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

    " Lang Plugins
    Plug 'lervag/vimtex'
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'sheerun/vim-polyglot'

    " Git Helpers
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Quality of Life
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'mhinz/vim-startify'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'xvzc/chezmoi.nvim'

    " Misc
    Plug 'matze/vim-move'       " move blocks of code
call plug#end()
" - - -- --- ----- Plugin Settings
" CHADTree {
    nnoremap <leader>v <cmd>CHADopen<cr>
" }

" Coc {
    let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-python', 'coc-vimtex', 'coc-go', 'coc-rust-analyzer']
" }
" NerdComment {
  let g:NERDSpaceDelims = 1                     " add space after comment char
  let g:NERDCompactSexyComs = 1                 " short syntax in comment blocks
" }

" VimTex {
  " let g:vimtex_view_method = 'zathura'
  let g:vimtex_view_general_viewer = 'okular'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" }

"- - -- --- ----- Misc
colorscheme catppuccin-frappe
let g:airline_theme = 'catppuccin'

autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty)
hi Normal ctermbg=none guibg=none " use terminal background

" Set up tmpl files syntax highlighting

augroup chezmoi_tmpl
    au!
    autocmd BufNewFile,BufRead *.tmpl set syntax=bash
    autocmd BufNewFile,BufRead *.kdl set syntax=bash
augroup END


" LUA Configs
if has("nvim")
lua << EOF

-- Set up Colorscheme
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "frappe",
    },
    transparent_background = true,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

local lsp = require "lspconfig"
local coq = require "coq"

lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.gopls.setup(coq.lsp_ensure_capabilities())
lsp.ts_ls.setup(coq.lsp_ensure_capabilities())
-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
EOF
endif


