set nocompatible

"*******************
" vim-plug
"*******************
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'kien/ctrlp.vim'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'ledger/vim-ledger', {'for': 'ledger'}
Plug 'jamessan/vim-gnupg'
Plug 'FooSoft/vim-argwrap'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc', {'on': 'Note'}
Plug 'xolox/vim-notes', {'on': 'Note'}
Plug 'bling/vim-bufferline'
Plug 'saltstack/salt-vim'
Plug 'hashivim/vim-terraform'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'editorconfig/editorconfig-vim'
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}

call plug#end()
"******************

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
set relativenumber
set nowrap
set pastetoggle=<F2>
set visualbell
set title
set showmatch
set smarttab
set backspace=indent,eol,start

" Search settings
set ignorecase
set smartcase
set incsearch
set hlsearch

" General mappings
let mapleader=","
nmap <Leader>W :w !sudo tee % > /dev/null<cr>
nmap <silent> <Leader>ev :e $MYVIMRC<cr>
nmap <silent> <Leader>sv :so $MYVIMRC<cr>
nmap <silent> <Leader>a :ArgWrap<cr>

autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
autocmd! BufNewFile,BufRead *.oz setlocal ft=oz
autocmd! BufNewFile,BufRead *.salsa setlocal ft=java
autocmd! BufNewFile,BufRead *.js6 setlocal ft=javascript
autocmd! BufNewFile,BufRead *.jsx6 setlocal ft=javascript
autocmd! BufNewFile,BufRead Dockerfile* setlocal ft=Dockerfile

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
autocmd Filetype eruby setlocal ts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab

" Definition for red text coloring
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

" Remove trailing whitespace on F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" ctrlp
" Ignore files in gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" argwrap
let g:argwrap_tail_comma = 1

" vim-notes
let g:notes_directories = ['~/notes']
let g:notes_suffix = '.txt'

" Hex editing
nnoremap <C-S-H> :Hexmode<CR>
inoremap <C-S-H> <ESC>:Hexmode<CR>
vnoremap <C-S-H> :<C-U>Hexmode<CR>

command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
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
au FileType ledger noremap <silent><buffer> <Leader>la :LedgerAlign<cr>
au FileType ledger noremap <silent><buffer> <Leader>lt
    \ :call ledger#transaction_state_toggle(line('.'), ' *!')<CR>

" Terraform
let g:terraform_fmt_on_save = 1

" Run rustfmt automatically
let g:rustfmt_autosave = 1

" Enter a tab literal
inoremap <S-Tab> <C-V><Tab>
