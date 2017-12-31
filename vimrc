" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options
set nocompatible

" Set leader to space key for other commands
let mapleader=' '

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
set autoindent
set smarttab

" Automatically toggle between hybrid and absolute line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

" Setup theme
set background=dark
colors zenburn

" Remove directory banner in netrw
let g:netrw_banner = 0

" Enable mouse click support in all modes
set mouse=a
