
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

set nobackup

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth'
  autocmd FileType text setlocal textwidth=120 colorcolumn=122
  augroup END

  augroup vimMarkdown
  au filetype markdown set spell spelllang=en textwidth=120 colorcolumn=122
  augroup END

  augroup vimJavaScript
  au filetype javascript set autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell
  au filetype javascript set textwidth=80 colorcolumn=82
  augroup END

  augroup vimJson
  au filetype json set autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab nospell
  au filetype json set textwidth=80 colorcolumn=82
  augroup END

  augroup vimRacket
  au filetype racket set autoindent expandtab nospell
  au filetype racket set textwidth=100 colorcolumn=102
  augroup END

else
  set autoindent
endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

set number relativenumber
set swapfile dir=/tmp
set wrap
set textwidth=120 colorcolumn=122
set formatoptions=qrn1
set updatetime=100
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
" set spell spelllang=en
" set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add
let g:scala_scaladoc_indent = 1

execute pathogen#infect()

"" SYNTASTIC https://github.com/vim-syntastic/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" TAGBAR https://github.com/preservim/tagbar.git
nmap <F8> :TagbarToggle<CR>
"set tags=tags;/

set list listchars=tab:⟶\ ,trail:·,extends:>,precedes:<,nbsp:%

"" https://wiki.archlinux.org/title/vim#Clipboard; `help 'clipboard'`
set clipboard=unnamedplus
