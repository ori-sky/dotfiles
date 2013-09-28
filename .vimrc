" allows plugins to be installed to ~/.vim/bundle
call pathogen#infect()

" 256 colors
set t_Co=256

" syntax highlighting
syntax on

" auto indenting
set ai

" if .lvimrc exists in parent directory of loaded file, load it as config
let lvimrc_path = expand('%:p:h') . '/.lvimrc'
if filereadable(lvimrc_path)
	execute 'so' lvimrc_path
endif
