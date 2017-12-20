" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options
set nocompatible

" Add Leader key for other commands
let mapleader=' '

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
set autoindent
set smarttab

set number

" Reload file if it is set outside of vim
set autoread

" Prevent accidental Ctrl+u
inoremap <C-U> <C-G>u<C-U>

" Display search as you type it
set incsearch

" Switch syntax highlighting on after loading theme
syntax enable
if !has('gui_running')
    set t_Co=256
endif

" Enable True Color Support
set termguicolors

set background=dark
colors zenburn
