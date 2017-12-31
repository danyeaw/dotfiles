" Start with vim settings
source ~/.vimrc

" Setup terminal colors
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

" Turn off vim status for lightline
set laststatus=2

call plug#begin('~/.vim/plugged')
Plug '~/.fzf' "Fuzzy search
Plug 'junegunn/fzf.vim' "FZF Plugin
Plug 'itchyny/lightline.vim' "Status line
Plug 'maximbaz/lightline-ale' "Lint support for status line
Plug 'itchyny/vim-gitbranch' "Display current git branch for status line
Plug 'Shougo/deoplete.nvim' "Autocomplete
Plug 'xolox/vim-easytags' "Ctags
Plug 'xolox/vim-misc' "Dependency of vim-easytags
Plug 'w0rp/ale' "Linter
Plug 'tmhedberg/SimpylFold' "Python folding support
call plug#end()

" Set colorscheme, add Git status, and ALE for Lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left':  [[ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]], 
      \   'right': [[ 'lineinfo'], ['percent'], [ 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ }

" Turn on deoplete at startup
let g:deoplete#enable_at_startup = 1

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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Disable ALE Highlighting
let g:ale_set_highlights = 0

" Setup ALE to only use Prospector for python
let g:ale_linters = {
        \ 'python': ['prospector'],
	\ }
