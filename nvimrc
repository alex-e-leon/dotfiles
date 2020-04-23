" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" See https://github.com/junegunn/vim-plug for more docs and usage
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' } 
Plug 'shime/vim-livedown'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'romainl/vim-cool'
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'jparise/vim-graphql'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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
let g:ale_fixers = {'javascript': ['eslint'], 'scss': ['stylelint']}
let g:ale_linters = {'javascript': ['eslint', 'flow', 'flow-language-server', 'jshint', 'standard']}

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

"Configure fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "path:fg:215,135,95" --colors "line:fg:128,128,128" --smart-case '.shellescape(<q-args>), 1, { 'options': '--color hl:223,hl+:222' }, 0)

"Custom mappings
"ctrl+p fzf
map <C-p> :FZF<CR>
"ctrl+c Toggle comments
map <C-c> :call NERDComment(0,"toggle")<CR>
"Leader+n Toggle file view
map <Leader>n <plug>NERDTreeTabsToggle<CR>
"Preview markdown files
map <Leader>p :LivedownToggle<CR>
"Fix lint errors with ALE fixers
map <Leader>f :ALEFix<CR>
"Move vertically by visual line
nnoremap j gj
nnoremap k gk

nnoremap [ :lnext<CR>
nnoremap ] :lprev<CR>
