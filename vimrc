call pathogen#infect()
filetype plugin indent on

syntax enable
colorscheme solarized
set background=dark

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap
set pastetoggle=<F2>

autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype haskell setlocal ts=4 sw=4 expandtab
autocmd Filetype go setlocal ts=4 sw=4 noexpandtab
autocmd Filetype coffee setlocal ts=2 sw=2 expandtab
