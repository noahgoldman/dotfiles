set nocompatible

"*******************
" Vundle Section
"*******************
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'altercation/vim-colors-solarized'
Plugin 'wting/rust.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'puppetlabs/puppet-syntax-vim'

call vundle#end()
filetype plugin indent on
"*******************
" End Vundle Section
"*******************

syntax enable
let &t_Co=256
let g:solarized_term = 1
colorscheme solarized
set background=dark

"Vim-latex settings
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Some nice filename tab completion
set wildmode=longest,list,full
set wildmenu

" Allow switching buffers without saving
set hidden

set nocompatible
set laststatus=2
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap
set pastetoggle=<F2>
set visualbell
set title

" Search settings
set ignorecase
set smartcase
set incsearch

autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype haskell setlocal ts=4 sw=4 expandtab
autocmd Filetype go setlocal ts=4 sw=4 noexpandtab
autocmd Filetype coffee setlocal ts=2 sw=2 expandtab
autocmd Filetype c setlocal ts=8 sw=8 noexpandtab
autocmd Filetype cpp setlocal ts=4 sw=4 expandtab
autocmd Filetype stylus setlocal ts=2 sw=2 expandtab
autocmd Filetype arduino setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype tex setlocal ts=4 sw=4 expandtab wrap
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype jade setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab

" Arduino detection
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
autocmd! BufNewFile,BufRead *.oz setlocal ft=oz
autocmd! BufNewFile,BufRead *.salsa setlocal ft=java

highlight Bad ctermbg=red ctermfg=white guibg=#592929
au BufWinEnter * let w:m2=matchadd('Bad', '\%>80v.\+', -1)" Highlight lines over 80 characters

" Highlight trailing whitespace
au InsertEnter * match Bad /\s\+\%#\@<!$/
au InsertLeave * match Bad /\s\+$/

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

" ctrlp
" Ignore files in gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
