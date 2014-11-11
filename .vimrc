" 256 colors
set t_Co=256

" syntax highlighting
syntax on

" auto indenting
set ai

" ruler
set ruler

" filetype plugin
filetype plugin on

" omni completion
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

"set tabstop
set tabstop=4

" autocmd haskell
autocmd FileType haskell setlocal expandtab shiftwidth=4 nojoinspaces

let &colorcolumn="81,".join(range(121,999),",")
highlight ColorColumn ctermbg=235

" home and end key mappings
imap <esc>OH <esc>0i
cmap <esc>OH <home>
nmap <esc>OH 0

nmap <esc>OF $
imap <esc>OF <esc>$a
cmap <esc>OF <end>

hi SpellBad ctermbg=darkred

set backspace=indent,eol,start

" if .lvimrc exists in parent directory of loaded file, load it as config
let lvimrc_path = expand('%:p:h') . '/.lvimrc'
if filereadable(lvimrc_path)
	execute 'so' lvimrc_path
endif
