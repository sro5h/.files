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

" Fix escape not triggering immediately
set ttimeoutlen=0

" Editing settings
" ------------------------------------------------------------------------------

" Show line numbers
set number
" Show the cursor line
set cursorline

" Indent 8 spaces wide
set tabstop=8
set shiftwidth=8
" Use spaces instead of tabs
set expandtab

" Enable list chars
set list
" Show trailing spaces
set listchars=trail:~

" Highlight search results
set hlsearch

" User defined mappings
" ------------------------------------------------------------------------------

" Clear the search highlight
nnoremap <silent> <cr> :nohlsearch<cr>

" User defined autocommands
" ------------------------------------------------------------------------------

augroup StartUp
        autocmd!
        " Don't insert comment leader on new lines
        autocmd FileType * setlocal formatoptions-=co
        " Indent 'private:' etc. correctly
        autocmd FileType cpp setlocal cinoptions+=g0l1N-s
        " Enable spell checking
        autocmd FileType gitcommit,markdown setlocal spell
augroup END
