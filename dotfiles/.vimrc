syntax on
filetype plugin indent on
colorscheme industry
set showmatch                           " 対応する括弧を強調表示
set title                               " ファイル名をタイトルに表示する
set autoindent
set number
set autochdir
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=2
"colorscheme murphy

set guifont=RictyDiminishedDiscord-Regular:h18

set wildmenu
set wildmode=list:longest,full

set hlsearch

packloadall
silent! helptags ALL

set clipboard+=unnamed

let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2


let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nnoremap <Leader>o :<C-u>execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')<CR>

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'gabrielelana/vim-markdown'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'tyru/open-browser.vim'
call plug#end()
