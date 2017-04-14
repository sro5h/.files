set nocompatible

"=============================================================================
" vim-plug
"=============================================================================
call plug#begin('~/.vim/plugins')
"
Plug 'sro5h/vim-deep-space'
Plug 'itchyny/lightline.vim'
Plug 'pgdouyon/vim-evanesco'
Plug 'sro5h/vim-syntax'
"
call plug#end()

"=============================================================================
" plugin settings
"=============================================================================
"
" lightline
"-----------------------------------------------------------------------------
set laststatus=2
let g:lightline={
    \ 'separator': { 'left': '>', 'right': '<' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }
"
" deep-space
"-----------------------------------------------------------------------------
let g:deepspace_italics=1

"=============================================================================
" vim settings
"=============================================================================
set encoding=utf8 " set file encoding to utf-8
set nobackup " disable auto backup
set noswapfile " disable swap files
" editor
colorscheme deep-space
set number
set relativenumber
set showcmd
let mapleader=" "
set tabstop=4
set shiftwidth=4
set expandtab " use spaces instead of tabs
set hlsearch " highlight search results
set incsearch " enable incremental search
" list chars
set list
set listchars=trail:•

"=============================================================================
" gui settings
"=============================================================================
if has("gui_running")
    set guioptions-=m " disable menu in vim gui
    set guioptions-=T " disable toolbar in vim gui
    set guioptions-=L " disable left scrollbar
    set guioptions-=r " disable right scrollbar
    set lines=999 columns=999 " maximize gvim window
    set guifont=Consolas:h10
    " disable bells
    augroup guicommands
        autocmd GUIEnter * set vb t_vb=
    augroup END
endif

"=============================================================================
" user defined mappings
"=============================================================================
" more comfortable split navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
" toggle spell
nnoremap <leader>s :set spell!<cr>
" edit vimrc
nnoremap <leader>v :edit $MYVIMRC<cr>
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

"=============================================================================
" user defined autocommands
"=============================================================================
augroup commands
    autocmd!
    autocmd VimEnter * echo "d[ o_0 ]b"
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
"
augroup autoqf
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
augroup END
"
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

"=============================================================================
" vim ignore settings
"=============================================================================
set wildignore+=*\\bin\\*,*\\build\\*,Makefile
