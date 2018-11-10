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
"       Vim license

" Plugins
" ------------------------------------------------------------------------------
call plug#begin('~/.vim/plugins')

Plug 'cocopon/iceberg.vim'
Plug 'sro5h/vim-syntax'

call plug#end()


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

" Enable list chars
set list
set listchars=trail:~

" Editing settings
" ------------------------------------------------------------------------------

" Set colorscheme
colorscheme iceberg

" Enable true color
set termguicolors

" Show line numbers
set number

" Indent 8 spaces wide
set tabstop=8
set shiftwidth=8
" Use spaces instead of tabs
set expandtab

" Highlight search results
set hlsearch

" User defined mappings
" ------------------------------------------------------------------------------

" Clear search highlight
nnoremap <silent> <cr> :nohlsearch<cr>

" User defined autocommands
" ------------------------------------------------------------------------------

augroup StartUp
        autocmd!
        " Don't insert comment leader on new lines
        autocmd FileType * setlocal formatoptions-=c formatoptions-=o
        " Indent 'private:' etc. correctly
        autocmd FileType cpp setlocal cinoptions+=g0l1N-s
        " Enable spell checking
        autocmd FileType gitcommit,markdown setlocal spell
augroup END
