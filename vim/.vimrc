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
Plug 'sro5h/vim-taglight'
"
call plug#end()


"=============================================================================
" Plugin settings
"=============================================================================
"
" Lightline
"-----------------------------------------------------------------------------
set laststatus=2
let g:lightline={
        \ 'colorscheme': 'deepspace',
        \ 'separator': { 'left': '>', 'right': '<' },
        \ 'subseparator': { 'left': '|', 'right': '|' }
        \ }
"
" Deep-space
"-----------------------------------------------------------------------------
let g:deepspace_italics=1

"=============================================================================
" General settings
"=============================================================================
set encoding=utf8 " Set file encoding to utf-8
set nobackup " Disable auto backup
set noswapfile " Disable swap files
" Editor
colorscheme deep-space
set termguicolors
set number
set showcmd
let mapleader=" "
set tabstop=8
set shiftwidth=8
set expandtab " Use spaces instead of tabs
set hlsearch " Highlight search results
set incsearch " Enable incremental search
set ttimeoutlen=0 " Disable esc delay in terminal
set noshowmode " Don't show the mode
" List chars
set list
set listchars=trail:•,tab:>\ 

"=============================================================================
" Gui & terminal settings
"=============================================================================
if has("gui_running")
        set guioptions-=m " Disable menu in vim gui
        set guioptions-=T " Disable toolbar in vim gui
        set guioptions-=L " Disable left scrollbar
        set guioptions-=r " Disable right scrollbar
        set lines=999 columns=999 " Maximize gvim window
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

"=============================================================================
" Functions
"=============================================================================
" Generate tags if the file 'tags' exists
function! GenerateTags()
        if filereadable("./tags")
                silent execute "!ctags -R ."
        endif
endfunction
" Show highlight group of the word under the cursor
function! ShowHighlight()
        echon "hi[" . synIDattr(synID(line("."),col("."),1),"name") . "] "
        echon "trans[" . synIDattr(synID(line("."),col("."),0),"name") . "] "
        echon "lo[" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . "]"
endfunction

"=============================================================================
" User defined mappings
"=============================================================================
" More comfortable split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Toggle spell
nnoremap <leader>s :set spell!<cr>
" Add a doxygen style comment
nnoremap <leader>c O/**<esc>o*<space><esc>hhxo*/<esc>k
" Edit vimrc
nnoremap <leader>v :edit $MYVIMRC<cr>
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" Show highlight
nnoremap <f10> :call ShowHighlight()<cr>

"=============================================================================
" User defined autocommands
"=============================================================================
augroup startup
        autocmd!
        autocmd VimEnter * echo "d[ o_0 ]b"
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
        autocmd FileType cpp setlocal cinoptions+=g0
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
"
augroup Tags
        autocmd!
        autocmd BufWritePost * call GenerateTags()
augroup END
