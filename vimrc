unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" On Windows, also use '.vim' instead of 'vimfiles'; this makes
" " synchronization across (heterogeneous) systems easier.
if has('win32')
  set runtimepath=$HOME/.vim,$HOME/.vim/plugins,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
  set packpath=$HOME/.vim
endif

" Make GVim and MacVim have nicer fonts
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" Set leader to space key for other commands
let mapleader=','

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Copy indention of current line
set autoindent

" Inserts correct spaces as tabs
set smarttab

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif


" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Automatically toggle between hybrid and absolute line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Reload file if it is set outside of vim
set autoread

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
colors seoul256 

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

" Enable mouse click support in all modes
set mouse=a

" Allow buffer switching without saving
set hidden
  
" Always show status line for last window
set laststatus=2

" Always show tabline
set showtabline=2

" Enable system clipboard for copy/paste
set clipboard=unnamedplus

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
  runtime! $VIMRUNTIME/macros/matchit.vim
endif

" Add Word Processor Mode from http://www.drbunsen.org/writing-in-vim/
func! WordProcessorMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  set thesaurus+=~/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
  set background=light
  packadd vimwiki
endfu 
com! WP call WordProcessorMode()
