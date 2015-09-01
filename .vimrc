"Syntax Highlighting
syntax on

"Vimgrep remap
command! -nargs=1 Find :execute "noautocmd vimgrep /" . <f-args> . "/ ./**/*"

"NerdCommenter remap
map <C-c> :call NERDComment(0,"toggle")<CR>

"Matchit QuickFix
:filetype plugin on

"Powerline setup
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2
set term=xterm-256color

"NerdtreeShortcuts and config
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

"Vundle Config
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" let Vundle manage Vundle required! 
Bundle 'gmarik/Vundle.vim'
Bundle 'jellybeans.vim'
Bundle 'Syntastic'
Bundle 'Lokaltog/powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ctrlp.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Yggdroot/indentLine'
Plugin 'loremipsum'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" Try set the color scheme to solarized
try
    set background=dark
    colorscheme solarized
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
let mapleader = '\'

function TabToSpaces( spaces )
  echo a:spaces
  let &shiftwidth=a:spaces
  let &tabstop=a:spaces
  set expandtab
  retab
endfunction 

command! -nargs=* TabToSpaces call TabToSpaces( '<args>' )
let g:vim_json_syntax_conceal = 0
