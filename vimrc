"Syntax Highlighting
syntax on
set nocursorcolumn
set nocursorline
set norelativenumber
syntax sync minlines=256
set synmaxcol=160

"Setup Linting
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_javascript_checkers = ['eslint']

"Change updatetime from 4s to 250ms to make gitgutter more responsive
set updatetime=250

"Show line numbers
set number

"Set leader to space
let mapleader = " "

"Prevent vim re-rendering during macros
set lazyredraw

"Matchit QuickFix
:filetype plugin on

"Set OSX system clipboard to work in vim
set clipboard=unnamed

"Set swapfile directory to home
set directory=~/.vim/swap//

"Detect .md files as Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"Powerline setup
set laststatus=2
set term=xterm-256color

"Nerdtree config
let NERDTreeIgnore = ['\.pyc$']

"Vundle Config
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" let Vundle manage Vundle required! 
Plugin 'gmarik/Vundle.vim'
Plugin 'jellybeans.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Yggdroot/indentLine'
Plugin 'loremipsum'
Plugin 'shime/vim-livedown'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

filetype plugin indent on     " required!
" see :h vundle for more details or wiki for FAQ

" Try set the color scheme to solarized
try
    set background=dark
    colorscheme jellybean
catch /E185:/
    colorscheme default
endtry

"Configure Solarized 
if exists('g:colors_name') && g:colors_name == 'solarized'
    " Text is unreadable with background transparency.
    if has('gui_macvim')
        set transparency=0
    endif

    " Highlighted text is unreadable in Terminal.app because it
    " does not support setting of the cursor foreground color.
    if !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
        let g:solarized_termcolors = &t_Co
        let g:solarized_termtrans = 1
        colorscheme solarized
    endif

    call togglebg#map("<F2>")
endif

"Configure indent-color
let g:indentLine_color_term = 52

"Tabs 
set shiftwidth=2
set tabstop=2
set expandtab
set list
set listchars=tab:>-

function TabToSpaces( spaces )
  echo a:spaces
  let &shiftwidth=a:spaces
  let &tabstop=a:spaces
  set expandtab
  retab
endfunction 

command! -nargs=* TabToSpaces call TabToSpaces( '<args>' )
let g:vim_json_syntax_conceal = 0

"Configure livedown
let g:livedown_port = 1227

"Configure extra space for comments
let NERDSpaceDelims=1

"Custom mappings

"ctrl+c Toggle comments
map <C-c> :call NERDComment(0,"toggle")<CR>
"Leader+n Toggle file view
map <Leader>n <plug>NERDTreeTabsToggle<CR>
"Preview markdown files
map <Leader>p :LivedownToggle<CR>
"Move vertically by visual line
nnoremap j gj
nnoremap k gk

nnoremap [ :lnext<CR>
nnoremap ] :lprev<CR>

"Vimgrep remap
command! -nargs=1 Find :execute "noautocmd vimgrep /" . <f-args> . "/ ./**/*"
