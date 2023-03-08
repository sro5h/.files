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

        echo('Cloning plugin ' . a:repository . ' into ' . s:directory)
        call system(s:command)
        echo('Done.')
endfunction

" Create plugin directory and download plugins
if v:version >= 800 && !isdirectory(b:plugin_directory)
        call ClonePlugin('sro5h', 'vim-syntax')
        call ClonePlugin('ziglang', 'zig.vim')
endif

" General settings
" ------------------------------------------------------------------------------

" Disable creation of backup files
set nobackup
" Disable creation of swap files
set noswapfile

" Don't show the current mode
set noshowmode
" Always show the status line
set laststatus=2

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

" Plugin settings
" ------------------------------------------------------------------------------
let g:zig_fmt_autosave = 0

" User defined mappings
" ------------------------------------------------------------------------------

" Clear the search highlight
nnoremap <silent> <cr> :nohlsearch<cr>

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
        autocmd FileType tex setlocal tabstop=4 shiftwidth=4
        autocmd FileType lua setlocal tabstop=4 shiftwidth=4
        " Enable folding by markers
        autocmd FileType lua setlocal foldmethod=marker foldlevel=99
augroup END
