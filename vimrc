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
Plugin 'fatih/vim-go'
Plugin 'lervag/vimtex'
Plugin 'ledger/vim-ledger'
Plugin 'jamessan/vim-gnupg'

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
autocmd Filetype tex setlocal ts=2 sw=2 expandtab wrap
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype jade setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype puppet setlocal ts=2 sw=2 expandtab

" Arduino detection
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
autocmd! BufNewFile,BufRead *.oz setlocal ft=oz
autocmd! BufNewFile,BufRead *.salsa setlocal ft=java

highlight Bad ctermbg=red ctermfg=white guibg=#592929

" Highlight lines over 80 characters
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('Bad', '\%>80v.\+', -1)" Highlight lines over 80 characters
endif

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

" Hex editing
nnoremap <C-S-H> :Hexmode<CR>
inoremap <C-S-H> <ESC>:Hexmode<CR>
vnoremap <C-S-H> :<C-U>Hexmode<CR>

command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" Ledger functionality
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 80
