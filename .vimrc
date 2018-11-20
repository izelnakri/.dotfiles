
set nocompatible

syntax enable
filetype plugin on

set incsearch
set hlsearch
set backspace=indent,eol,start

set path+=**
set wildmenu

set autoindent
set nowrap
set nobackup
set history=50
set ruler
set showcmd



command! MakeTags !ctags -R .
