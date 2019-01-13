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
        call ClonePlugin('protesilaos', 'prot16-vim')
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

" Fix escape not triggering immediately
set ttimeoutlen=0

" Enable true color support
set termguicolors
" Set vim-specific sequences for RGB colors
let &t_8f="\<esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<esc>[48;2;%lu;%lu;%lum"

" Editing settings
" ------------------------------------------------------------------------------

" Set colorscheme
colorscheme hinterland_dark
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
