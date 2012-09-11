call pathogen#infect()
filetype plugin indent on

syntax enable
set background=dark
colorscheme solarized

" Powerline settings
let g:powerline_symbols='fancy'

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

autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype haskell setlocal ts=4 sw=4 expandtab
autocmd Filetype go setlocal ts=4 sw=4 noexpandtab
autocmd Filetype coffee setlocal ts=2 sw=2 expandtab
autocmd Filetype c setlocal ts=8 sw=8 noexpandtab
autocmd Filetype cpp setlocal ts=2 sw=2 expandtab
autocmd Filetype stylus setlocal ts=2 sw=2 expandtab
autocmd Filetype arduino setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype modula2 setlocal ts=4 sw=4 expandtab wrap

" Arduino detection
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino

" Highlights lines that go over 80 characters
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
