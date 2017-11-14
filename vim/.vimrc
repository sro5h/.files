"
" .vimrc
"
" Author:
"     Paul Meffle
"
" Summary:
"     My personal vim configuration
"
" License:
"     Vim license

" Plugins {{{
"-----------------------------------------------------------------------------

call plug#begin('~/.vim/plugins')

Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-slash'
Plug 'sro5h/vim-syntax'
Plug 'sro5h/vim-taglight'
Plug 'rust-lang/rust.vim'
Plug 'sro5h/vim-greetings'

call plug#end()

" }}}
" Plugin settings {{{
"-----------------------------------------------------------------------------

" Lightline
let g:lightline={
        \ 'colorscheme': 'iceberg',
        \ 'separator': { 'left': '>', 'right': '<' },
        \ 'subseparator': { 'left': '|', 'right': '|' }
        \ }

" Deep-space
let g:deepspace_italics=1

" }}}
" General settings {{{
"-----------------------------------------------------------------------------

" Disable auto backup
set nobackup
" Disable swap files
set noswapfile

" Disable esc delay in terminal
set ttimeoutlen=0

" Don't show the mode
set noshowmode
" Show the current command
set showcmd
" Always show the status line
set laststatus=2

" List chars
set list
set listchars=trail:•,tab:>\ 

" Enable folding
set foldmethod=marker
" Start with all folds open
set foldlevelstart=99

" }}}
" Editing settings {{{
"-----------------------------------------------------------------------------

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
" Enable incremental search
set incsearch
" Ignore case while searching
set ignorecase
" ^ unless a capital letter is used
set smartcase

" }}}
" Gui & terminal settings {{{
"-----------------------------------------------------------------------------

if has("gui_running")
        " Disable all unnecessary gui options
        set guioptions=c

        " Maximize gvim window
        set lines=999 columns=999
        " Font settings
        set guifont=Consolas:h10

        " Disable bells
        augroup guicommands
                autocmd GUIEnter * set vb t_vb=
        augroup END
else
        " Cursor shape in terminal
        let &t_SI = "\<Esc>[6 q"
        let &t_SR = "\<Esc>[4 q"
        let &t_EI = "\<Esc>[2 q"
endif

" }}}
" Functions {{{
"-----------------------------------------------------------------------------

" Generate tags if the file 'tags' exists
function! GenerateTags() abort
        if filereadable("./tags")
                silent execute "!ctags -R ."
        endif
endfunction

" Show highlight group of the word under the cursor
function! ShowHighlight() abort
        echon "hi[" . synIDattr(synID(line("."),col("."),1),"name") . "] "
        echon "trans[" . synIDattr(synID(line("."),col("."),0),"name") . "] "
        echon "lo[" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . "]"
endfunction

" }}}
" User defined mappings {{{
"-----------------------------------------------------------------------------

" Use space as leader
let mapleader=" "

" More comfortable split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle spell
nnoremap <leader>s :set spell!<cr>

" Add a doxygen style comment
nnoremap <leader>d O/**<esc>o*<space><esc>hhxo*/<esc>k

" Partial file name matching
nnoremap <leader>e :e **/*

" Edit vimrc
nnoremap <leader>v :edit $MYVIMRC<cr>

" Show highlight
nnoremap <f10> :call ShowHighlight()<cr>

" Shortcut to get the current directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" }}}
" User defined autocommands {{{
"-----------------------------------------------------------------------------

augroup Startup
        autocmd!
        autocmd VimEnter * echo greetings#RandomGreeting()
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
        " Indent 'private:' etc. correctly
        autocmd FileType cpp setlocal cinoptions+=g0
        " Enable spell checking
        autocmd FileType gitcommit,markdown setlocal spell
augroup END

" Automatically open the quickfix window when it gets filled
augroup AutoQf
        autocmd!
        autocmd QuickFixCmdPost [^l]* cwindow
        autocmd QuickFixCmdPost    l* lwindow
augroup END

" Show the cursorline only in the focused window
augroup CursorLineOnlyInFocusedWindow
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
augroup END

augroup Tags
        autocmd!
        autocmd BufWritePost * call GenerateTags()
augroup END

" }}}
