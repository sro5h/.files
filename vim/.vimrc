"
" .vimrc
"
" Author:
"       Paul Meffle
"
" Summary:
"       My personal vim configuration
"
" License:
"       MIT license

" Plugin setup, depends on the plugin manager introduced in vim 8
" ------------------------------------------------------------------------------

" Turn on filetype and syntax support
filetype plugin indent on
syntax on

" The plugin directory
let b:plugin_directory = $HOME . '/.vim/pack/sro5h/start/'

" Clones a git repository into the plugin directory
function! ClonePlugin(user, repository)
    let s:github_url = 'https://github.com/' . a:user . '/' . a:repository
    let s:directory  = b:plugin_directory . a:repository
    let s:command    = 'git clone ' . s:github_url . ' ' . s:directory

    if !isdirectory(s:directory)
        echo('Cloning plugin ' . a:repository . ' into ' . s:directory)
        call system(s:command)
        echo('Done.')

        let s:doc_dir = s:directory . '/doc/'
        if isdirectory(s:doc_dir)
            exe 'helptags' . s:doc_dir
        endif
    endif
endfunction

" Create plugin directory and download plugins
if v:version >= 800
    call ClonePlugin('donaldttt', 'fuzzyy')
    call ClonePlugin('sro5h', 'vim-syntax')
    call ClonePlugin('lervag', 'vimtex')
endif

" General settings
" ------------------------------------------------------------------------------

" Disable creation of backup files
set nobackup
" Disable creation of swap files
set noswapfile

" Don't show the current mode
set noshowmode
" Show relative numbers
set relativenumber
" Show cursor line
set cursorline

" Enable UTF-8 encoding
set encoding=utf-8

" Remove pipe characters from buffer separators
set fillchars+=vert:\ 

" Specify what to store in session files
set sessionoptions=blank,buffers,tabpages,sesdir

" Editing settings
" ------------------------------------------------------------------------------

" Set dark background
set background=dark

" Indent 4 spaces wide
set tabstop=4
set shiftwidth=4
" Use spaces instead of tabs
set expandtab

" Enable indentation on new lines
set cindent

" Enable list chars
set list
" Show trailing spaces
set listchars=trail:~

" Highlight search results
set hlsearch

" Status line
" ------------------------------------------------------------------------------

" Always show the status line
set laststatus=2

" Get syntax group of character under cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    return l:s ? synIDattr(l:s, 'name') . '->' . synIDattr(synIDtrans(l:s),
        \'name') : ''
endfun

function! RelFileName()
    let l:s = expand('%:~:.')
    return len(l:s) > 0 ? l:s : '[empty]'
endfun

set statusline=
" Relative file name
set statusline+=\ %{RelFileName()}
" Buffer flags
set statusline+=\ %y%r%m
" Right align the rest
set statusline+=%=
set statusline+=%{SynGroup()}\ 
" Line and column number with padding
set statusline+=%-9.(%l,%v%)
" File percentage
set statusline+=\ %P\ 

" Tab line
" ------------------------------------------------------------------------------

" Always show the tab line
set showtabline=2

set tabline=
" Current tabpage
set tabline+=\ Tab\ %{tabpagenr()}\ of\ %{tabpagenr('$')}
" Right align the rest
set tabline+=%=
" Current working directory
set tabline+=\ %{getcwd()}\ 

" Plugin settings
" ------------------------------------------------------------------------------

let g:fuzzyy_window_layout = {
\   'files': {
\       'preview': 0,
\       'width': 0.5,
\       'height': 0.5,
\   }
\}
let g:fuzzyy_borderchars = ['━', '┃', '━', '┃', '┏', '┓', '┛', '┗']

" User defined mappings
" ------------------------------------------------------------------------------

let g:mapleader = ' '
let g:maplocalleader = ' '

" Clear the search highlight
nnoremap <silent> <cr> :nohlsearch<cr>

" Open fuzzy finder
nnoremap <silent> <leader>e :FuzzyFiles<cr>

" User defined autocommands
" ------------------------------------------------------------------------------

let c_no_curly_error=1

augroup StartUp
    autocmd!
    " Don't insert comment leader on new lines
    autocmd FileType * setlocal formatoptions-=o
    " Indent 'private:' etc. correctly
    autocmd FileType cpp setlocal cinoptions+=g0l1N-s
    " Enable spell checking
    autocmd FileType gitcommit,markdown setlocal spell
    " Smaller indentation
    autocmd FileType tex setlocal tabstop=2 shiftwidth=2 spell spelllang=en_gb spellfile=spell/en.utf-8.add
    autocmd FileType lua setlocal tabstop=4 shiftwidth=4
    " Enable folding by markers
    autocmd FileType lua setlocal foldmethod=marker foldlevel=99
augroup END
