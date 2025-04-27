vim9script

# Turn on filetype and syntax support
filetype plugin indent on
syntax on

# Plugin setup {{{
# ---------------------------------------------------------------------------

var plugin_dir = $HOME .. '/.vim/pack/sro5h/start/'

# Clone a git repository into `plugin_dir`
def ClonePlugin(repository: string, user: string)
    var github_url = 'https://github.com/' .. user .. '/' .. repository
    var dir = plugin_dir .. repository
    var command = 'git clone ' .. github_url .. ' ' .. dir

    if !isdirectory(dir)
        echo 'Cloning plugin ' .. repository .. ' into ' .. dir
        system(command)
        echo 'Done.'

        var doc_dir = dir .. '/doc'

        if isdirectory(doc_dir)
            execute 'helptags ' .. doc_dir
        endif
    endif
enddef

# Download plugins
ClonePlugin('fuzzyy', 'donaldttt')
ClonePlugin('vim-syntax', 'sro5h')
ClonePlugin('vimtex', 'lervag')

# }}}

# General settings {{{
# ------------------------------------------------------------------------------

# Enable UTF-8 encoding
set encoding=utf-8

# Disable creation of backup files
set nobackup
# Disable creation of swap files
set noswapfile

# Specify what to store in session files
set sessionoptions=blank,buffers,tabpages,sesdir

# Disable intro message
set shortmess+=I

# Fix redrawing while playing back commands
set lazyredraw

# }}}

# Editing settings {{{
# ------------------------------------------------------------------------------

# Use spaces instead of tabs
set expandtab
# Indent 4 spaces wide
set tabstop=4
set shiftwidth=4

# Enable indentation on new lines
set cindent

# Enable folding by markers
set foldmethod=marker
set foldlevel=99

# }}}

# Visual settings {{{
# ------------------------------------------------------------------------------

# Set dark background
set background=dark
# Set color scheme
colorscheme custom

# Don't show current mode
set noshowmode
# Show relative numbers
set relativenumber
# Show cursor line
set cursorline

# Keep cursor line centered
set scrolloff=999

# Don't highlight search results
set nohlsearch
set incsearch
set ignorecase
set smartcase

# Remove pipe characters from buffer separators
set fillchars+=vert:\ 

# Enable list chars
set list
# Show trailing spaces
set listchars=trail:~

# Use popup for wildmenu
set wildoptions+=pum

# }}}

# Status line {{{
# ------------------------------------------------------------------------------

# Always show status line
set laststatus=2

# Get syntax group of character under cursor
def g:SynGroup(): string
    var s = synID(line('.'), col('.'), 1)

    if s != 0
        return synIDattr(s, 'name') .. '->' .. synIDattr(synIDtrans(s), 'name')
    else
        return ''
    endif
enddef

def g:RelFileName(): string
    var path = expand('%:~:.')
    return len(path) > 0 ? path : '[empty]'
enddef

set statusline=
# Relative file name
set statusline+=\ %{RelFileName()}
# Buffer flags
set statusline+=\ %y%r%m
# Right align rest
set statusline+=%=
# Current syntax group
set statusline+=%{SynGroup()}\ 
# Line and column number with padding
set statusline+=%-9.(%l,%v%)
# File percentage
set statusline+=\ %P\ 

# }}}

# Tab line {{{
# ------------------------------------------------------------------------------

# Always show the tab line
set showtabline=2

def g:TabLineStr(): string
    # Show tab list
    var str = 'Tabs:'
    var page = 1
    while page <= tabpagenr('$')
        str = str .. (tabpagenr() == page ? ' %#TabLineSel#*%#TabLine#' : ' *')
        page += 1
    endwhile

    # Right align cwd
    str = str .. '%= %{getcwd()} '

    return str
enddef

set tabline=%{%TabLineStr()%}

# }}}

# Plugin settings {{{
# ------------------------------------------------------------------------------

g:c_no_curly_error = 1

g:netrw_altfile = 1
g:netrw_banner = 0

g:fuzzyy_dropdown = 1
g:fuzzyy_window_layout = {
    'files': {
        'preview': 0,
        'width': 0.5,
        'height': 8,
    },
}
g:fuzzyy_borderchars = ['━', '┃', '━', '┃', '┏', '┓', '┛', '┗']

g:vimtex_syntax_nospell_comments = 1
g:vimtex_compiler_latexmk = {'out_dir': 'build'}

# }}}

# Custom mappings {{{
# ------------------------------------------------------------------------------

# Custom sneak
nnoremap s /\M
nnoremap S ?\V

# Clear the search highlight
nnoremap <silent> <cr> :nohlsearch<cr>

# Window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j

# TODO: Change leader to `;` and use `<space>` to alternate folds

# Open netrw
nnoremap <silent> - :Explore<cr>

g:mapleader = ' '
g:maplocalleader = ' '

# Move to beginning of previous fold
nnoremap <leader>j zj
nnoremap <leader>k zk[z

# Edit vimrc
nnoremap <silent> <leader>v :e $MYVIMRC<cr>

# Open fuzzy finder
nnoremap <silent> <leader>e :FuzzyFiles<cr>
nnoremap <silent> <leader>b :FuzzyBuffers<cr>

# Start vimtex compilation
nnoremap <silent> <leader>c :VimtexCompile<cr>

# }}}

# Custom autocommands {{{
# ------------------------------------------------------------------------------

augroup StartUp
    autocmd!
    # Don't insert comment leader on new lines
    autocmd FileType * setlocal formatoptions-=o
    # Indent 'private:' etc. correctly
    autocmd FileType cpp setlocal cinoptions+=g0l1N-s
    # Enable spell checking
    autocmd FileType gitcommit,markdown setlocal spell
    # Smaller indentation
    autocmd FileType tex setlocal tabstop=2 shiftwidth=2 spell spelllang=en_gb spellfile=spell/en.utf-8.add
augroup END

augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

# }}}
