" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" See https://github.com/junegunn/vim-plug for more docs and usage
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vimscripts/loremipsum', { 'on': 'Loremipsum' } 
Plug 'shime/vim-livedown'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'romainl/vim-cool'
Plug 'w0rp/ale'

" color schemes
Plug 'AlessandroYorba/Despacio'
" Plug 'mbbill/vim-seattle'
" Plug 'AlessandroYorba/Sierra'
" Plug 'thewatts/wattslandia' | Plug 'jordwalke/flatlandia'

" Initialize plugin system
call plug#end()

"Syntax Highlighting
syntax on
set nocursorcolumn
set nocursorline
set relativenumber
syntax sync minlines=256
set synmaxcol=160

"Configure ALE syntax highlighting
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>-'

" configure airline to use powerline fonts
let g:airline_powerline_fonts = 1

"Change updatetime from 4s to 250ms to make gitgutter more responsive
set updatetime=250

"Show line numbers
set number

"Set leader to space
let mapleader = " "

"Prevent vim re-rendering during macros
set lazyredraw

"Set OSX system clipboard to work in vim
set clipboard=unnamed

"Set swapfile directory to home
set directory=~/.local/share/nvim/swap//

"Detect .md files as Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"Nerdtree config
let NERDTreeIgnore = ['\.pyc$']

"Configure colorscheme
set termguicolors
colorscheme despacio

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
