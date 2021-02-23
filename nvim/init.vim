"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set hidden

" Change leader to space, because why not
let mapleader=" "
" Dismiss those nasty sounds
set noerrorbells visualbell t_vb=

" spacing
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set backspace=indent,eol,start

" line number stuff
syntax enable
set ruler
set number " Show current line number
set relativenumber " Show relative line numbers
set cursorline " Highlight current line
set showmatch " Show matching part of bracket pairs [] () {}
set nu
set scrolloff=4 " Autoscroll on edges
set signcolumn=yes
set colorcolumn=80,120 " two width columns

" More natural split opening
set splitbelow
set splitright
set noequalalways

" buffer / backup / undo
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Show (partial) command in status line.
set showcmd

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Testing
Plug 'vim-test/vim-test'

" Python stuff
Plug 'vim-python/python-syntax'
Plug 'morhetz/gruvbox'
call plug#end()

filetype plugin indent on
syntax on

" vim-test
let test#strategy = "neovim"

" Colorscheme
set termguicolors
set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1

" gitgutter
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_set_sign_backgrounds = 1
" highlight link GitGutterAdd Underlined
" highlight link GitGutterChangeLine Underlined
highlight link GitGutterChangeLineNr Underlined

" gitblamer
let g:blamer_enabled = 1
let g:blamer_delay = 400
let g:blamer_relative_time = 1

"" Enable cursor mode shapes
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

"" Disable displaying --INSERT--
set noshowmode

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" IndentLine {{
" let g:indentLine_first_char = '⎸'
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_setColors = 1
let g:indentLine_defaultGroup = 'SpecialKey'
" }}
set listchars=eol:↩,tab:>·,trail:~,extends:>,precedes:<,space:_
set list

" Own keybindings
nnoremap <silent> <leader>tw :set list!<CR>


" Customized FZF
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <Leader>ff :FzfFiles<CR>
nnoremap <silent> <Leader>fg :FzfAg<CR>
nnoremap <silent> <Leader>fc :FzfCommits<CR>
nnoremap <silent> <Leader>fl :FzfLines<CR>
nnoremap <silent> <Leader>e :FzfHistory<CR>

let g:python_highlight_all = 1


" Color overwrites
hi CursorLineNr guifg='#b8bb26' cterm=None 
hi ColorColumn ctermbg=0 guibg='#32302f'
" vim-gitgutter used to do this by default:
highlight! link SignColumn LineNr
