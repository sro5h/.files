set nocompatible

"===============================================
" vim-plug
"===============================================
call plug#begin('~/.vim/plugins')
"
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'ajh17/VimCompletesMe'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'marcweber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate' | Plug 'sro5h/snippets'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/filestyle'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mhinz/vim-startify'
"
call plug#end()

"===============================================
" plugin settings
"===============================================
"
" netrw
"-----------------------------------------------
let g:netrw_liststyle=0
"
" airline
"-----------------------------------------------
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_min_count=1
let g:airline_theme='deep_space'
let g:airline_powerline_fonts=1
let g:airline_left_sep='>'
let g:airline_right_sep='<'
"
" ctrlp
"-----------------------------------------------
let g:ctrlp_show_hidden=1
let g:ctrlp_root_markers=['.git', '.vimprj', 'premake5.lua']
"
" vim-oblique
"-----------------------------------------------
let g:oblique#incsearch_highlight_all=1

"===============================================
" vim settings
"===============================================
set t_Co=16
set background=dark
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
set tw=1000 " disable highlighting of long lines
set scrolloff=1
set cursorline " highlight the cursorline
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
"else
    " this is console Vim.
    "if exists("+lines")
        "set lines=50
    "endif
    "if exists("+columns")
        "set columns=100
    "endif
endif

"===============================================
" user defined functions
"===============================================

"===============================================
" user defined mappings & operators & commands
"===============================================
"
" mappings
"-----------------------------------------------
" disable arrow keys in insert mode
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
"nnoremap - ddp
" autocomplete mapping
inoremap <C-c> <C-x><C-u>
" leader mappings
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
" add & remove a semicolon to the end of the line if nonexistant
nnoremap <expr> <leader>s getline('.') =~ ';$' ? '' : "mqA;\<esc>`q"
nnoremap <expr> <leader>S getline('.') =~ ';$' ? "mq$x\<esc>`q" : ''
nnoremap <leader>u viwU
nnoremap <leader>\ :rightbelow vsplit<cr>
nnoremap <leader>\| :rightbelow split<cr>
nnoremap <leader>y :call emmet#expandAbbr(3,"")<cr>
nnoremap <silent> <leader><CR> :noh<CR>
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
nnoremap <leader>f :FileStyleFix<esc>
" more comfortable split navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>v :e $MYVIMRC<cr>
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
    "au VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
    "au InsertEnter,InsertLeave * set cursorline!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " source vimrc after save
    autocmd bufwritepost .vimrc source $MYVIMRC
    "au BufRead *.vimprj call LoadProject() Make project plugin that sources loaded project files
augroup END

"===============================================
" vim ignore settings
"==============================================-
set wildignore+=*\\bin\\*,*\\build\\*,Makefile
