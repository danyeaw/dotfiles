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
" Turn off vim status for lightline
set laststatus=2

" Reload file if it is set outside of vim
set autoread

" Prevent accidental Ctrl+u
inoremap <C-U> <C-G>u<C-U>

" Display search as you type it
set incsearch

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-jedi'
call plug#end()

" Switch syntax highlighting on after loading theme
syntax enable
if !has('gui_running')
    set t_Co=256
endif
set background=dark
colors zenburn

" let g:deoplete#enable_at_startup = 1

" Add :Find command to fzf search
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
