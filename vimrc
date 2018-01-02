" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options
set nocompatible

" Set leader to space key for other commands
let mapleader=' '

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Enable file type detection and do language-dependent indenting.
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Copy indention of current line
set autoindent

" Inserts correct spaces as tabs
set smarttab

" Terminal timeout for part of key code sequence received by terminal
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Display search as you type it
set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Enable ruler
set ruler

" Enable enhanced tab completion through cycling through different options when
set wildmenu

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

" Switch syntax highlighting on after loading theme
syntax enable
if !has('gui_running')
    set t_Co=256
endif

" Show EOL$ as last char
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Enable True Color Support
set termguicolors

" Setup theme
set background=dark
colors zenburn

" Remove directory banner in netrw
let g:netrw_banner = 0

" Absolute width of netrw window
let g:netrw_winsize = -28

" Tree-view
let g:netrw_liststyle = 3

" Sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" Use the previous window to open file
let g:netrw_browse_split = 4

" Map Ctrl+E to netrw
nmap <silent> <C-E> :Lexplore<CR>

" Change directory to the current buffer when opening files.
set autochdir

" Enable mouse click support in all modes
set mouse=a

" remap arrow keys
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>

" Allow buffer switching without saving
set hidden
  
" Always show status line for last window
set laststatus=2

" Always show tabline
set showtabline=2

" Enable CTags in .git directory
set tags=./.git/tags;

" Set min history
if &history < 1000
  set history=1000
endif
" Max tabs, should default to 50
if &tabpagemax < 50
  set tabpagemax=50
endif

" Get global options and mappings from settings files, not saved in session
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim (% matching), but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
