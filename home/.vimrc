source $VIMRUNTIME/defaults.vim

set nobackup
set swapfile dir=/tmp

" open split windows on the right/below
set splitbelow
set splitright

set hlsearch

set number relativenumber
set nowrap

" :help fo-table
" q	Allow formatting of comments with 'gq'
" r	Automatically insert the current comment leader after hitting <Enter> in Insert mode
" n	When formatting text, recognize numbered lists.
" 1	Don't break a line after a one-letter word.  It's broken before it instead (if possible).
set formatoptions=qrn1

set colorcolumn=122
highlight ColorColumn ctermbg=52

" show tabs and trailing spaces
set list listchars=tab:⟶\ ,trail:·,extends:>,precedes:<,nbsp:%

set tabstop=2
set softtabstop=2
set shiftwidth=2

set smartindent
set autoindent

augroup vimRust
	au filetype rust set tabstop=4
augroup END

augroup vimMarkdown
	au filetype markdown set spell spelllang=en tabstop=2 softtabstop=2 shiftwidth=2
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://github.com/tpope/vim-fugitive
" https://github.com/airblade/vim-gitgutter
highlight! link SignColumn LineNr
set signcolumn=yes
set updatetime=100

" https://github.com/vim-airline/vim-airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" https://github.com/mbbill/undotree
nnoremap <F5> :UndotreeToggle<CR>

" https://github.com/markonm/traces.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>

" move line/selection up/down one line
nnoremap <C-k> mz:m -2<CR>==`z:delm z<CR>
nnoremap <C-j> mz:m +1<CR>==`z:delm z<CR>
vnoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-j> :m '>+1<CR>gv=gv

" keep cursor in the middle when scrolling up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" select word under cursor and replace all occurences
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
