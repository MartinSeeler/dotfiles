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

Plug 'junegunn/limelight.vim'

" Testing
Plug 'vim-test/vim-test'

" Programming stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'sillybun/vim-repl'
Plug 'vim-python/python-syntax'
Plug 'morhetz/gruvbox'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sheerun/vim-polyglot'
Plug 'pineapplegiant/spaceduck'
Plug 'KeitaNakamura/neodark.vim'
call plug#end()

let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n\n'

filetype plugin indent on
syntax on

" vim-test
let test#strategy = "neovim"

let g:repl_program = {
            \   'python': 'python',
            \   'default': 'zsh',
            \   'r': 'R',
            \   'lua': 'lua',
            \   'vim': 'vim -e',
            \   }

" Colorscheme
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" set background=dark
let g:neodark#background = '#202020'
let g:neodark#use_256color = 1

colorscheme nightfly
" let g:airline_theme='gruvbox'
" let g:airline_theme = 'spaceduck'
let g:airline#extensions#tabline#enabled = 1

" gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_set_sign_backgrounds = 0
" let g:gitgutter_highlight_lines = 1
let g:gitgutter_highlight_linenrs = 1
" let g:gitgutter_
highlight link GitGutterAdd GruvboxGreen
highlight link GitGutterAddLineNr GruvboxGreen
highlight link GitGutterChange GruvboxAqua
highlight link GitGutterChangeLineNr GruvboxAqua
highlight link GitGutterDelete GruvboxRed
highlight link GitGutterDeleteLineNr GruvboxRed

" gitblamer
let g:blamer_enabled = 1
let g:blamer_delay = 400
let g:blamer_relative_time = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
highlight Blamer guibg=None guifg=lightgrey

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
hi link CursorLineNr GruvboxGreen
" hi ColorColumn ctermbg=0 guibg='#32302f'
" vim-gitgutter used to do this by default:
highlight! link SignColumn LineNr

lua << EOF
local nvim_lsp = require('lspconfig')
local lsp_completion = require("completion")

--Enable completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  require('completion')
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>cd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ch', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>ci', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  if client.resolved_capabilities.completion then
    lsp_completion.on_attach(client, bufnr)
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightGray guifg=green
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_auto_popup = 0
let g:completion_trigger_character = ['.', '::']
nnoremap z :call LanguageClient_contextMenu()<CR>
let g:lsp_diagnostics_enabled = 1

" show diagnostic signs
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '!'}

" Do not use virtual text, they are far too obtrusive.
let g:lsp_virtual_text_enabled = 0
" echo a diagnostic message at cursor position
let g:lsp_diagnostics_echo_cursor = 0
" show diagnostic in floating window
let g:lsp_diagnostics_float_cursor = 1
" whether to enable highlight a symbol and its references
let g:lsp_highlight_references_enabled = 1
let g:lsp_preview_max_width = 80
imap <silent> <C-space> <Plug>(completion_trigger)

" Avoid showing message extra message when using completion
set shortmess+=c

" Reopen the last edited position in files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
