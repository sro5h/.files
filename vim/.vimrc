set nocompatible

"===============================================
" vim-plug
"===============================================
call plug#begin('~/.vim/plugins')
"
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'marcweber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate' | Plug 'sro5h/snippets.vim'
Plug 'pgdouyon/vim-evanesco'
Plug 'sro5h/syntax.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mhinz/vim-startify'
"
call plug#end()

"===============================================
" plugin settings
"===============================================
"
" airline
"-----------------------------------------------
set laststatus=2
let g:airline_theme='deep_space'
let g:airline_left_sep='>'
let g:airline_right_sep='<'
"
" deep-space
"-----------------------------------------------
let g:deepspace_italics=1
"

"===============================================
" vim settings
"===============================================
set encoding=utf8 " set file encoding to utf-8
set noautochdir " prevent vim from changing the pwd
set nobackup " disable auto backup
set noswapfile " disable swap files
set updatetime=250 " lower update time
" editor
colorscheme deep-space
set number
set relativenumber
set ruler " show line number & column
set showcmd
set nowrap
let mapleader=" "
set scrolloff=1
"set cursorline " highlight the cursorline
set backspace=indent,eol,start " proper deletion with backspace
set tabstop=4
set shiftwidth=4
set expandtab " use spaces instead of tabs
set hlsearch " highlight search results
set incsearch " enable incremental search
set splitbelow
set splitright
" zsh esc delay fix
set timeoutlen=1000 ttimeoutlen=0
set lazyredraw
" list chars
set list
set listchars=extends:>
set listchars+=precedes:<
set listchars+=trail:•

"===============================================
" gui settings
"===============================================
if has("gui_running")
    set guioptions-=m " disable menu in vim gui
    set guioptions-=T " disable toolbar in vim gui
    set guioptions-=L " disable left scrollbar
    set guioptions-=r " disable right scrollbar
    " set lines =50 columns=120 " initial size of vim (gui)
    set lines=999 columns=999 " maximize gvim window
    set guifont=Consolas:h10
    " disable bells
    augroup guicommands
        autocmd GUIEnter * set vb t_vb=
    augroup END
else

"===============================================
" user defined functions
"===============================================
"
"===============================================
" user defined mappings & operators & commands
"===============================================
"
" leader mappings
"-----------------------------------------------
" add & remove a semicolon to the end of the line if nonexistant
nnoremap <expr> <leader>s getline('.') =~ ';$' ? '' : "mqA;\<esc>`q"
nnoremap <expr> <leader>S getline('.') =~ ';$' ? "mq$x\<esc>`q" : ''
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
" more comfortable split navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap <leader>f :e **/*
"
" operators
"-----------------------------------------------
" in next & in last (has problems with empties)
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
onoremap in< :<c-u>normal! f<vi<<cr>
onoremap il< :<c-u>normal! F>vi<<cr>
"
" commands
"-----------------------------------------------
augroup commands
    autocmd!
    autocmd VimEnter * echo "d[ o_0 ]b"
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
"
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

"===============================================
" vim ignore settings
"==============================================-
set wildignore+=*\\bin\\*,*\\build\\*,Makefile
