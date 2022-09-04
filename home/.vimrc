" .vimrc
set nocompatible

" load .exrc and modify its settings
so $HOME/.exrc
set noshowmatch

" settings for vim only
set incsearch
set hlsearch
set copyindent

if has('syntax')
	syntax on
	colorscheme default
endif
