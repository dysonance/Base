" neovim config file to be placed at the following location:
" ~/.config/nvim/init.vim
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
set runtimepath+=~/.local/share/nvim/site/autoload
set runtimepath+=~/.local/share/nvim/plugged
let &packpath = &runtimepath

" dependency paths
let g:ruby_host_prog="~/Applications/Brew/src/opt/ruby/bin/ruby"
let g:python_host_prog="~/Applications/Frameworks/Python.framework/Versions/2.7/bin/python"
let g:python3_host_prog="~/Applications/Frameworks/Python.framework/Versions/3.8/bin/python3"

" take standard python configuration
source ~/.vimrc

" " deoplete debugging (unsolved wip)
" set nocompatible
" filetype off
" call plug#begin(stdpath('data') . '/plugged')
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'deoplete-plugins/deoplete-jedi'
" cal plug#end()
" let g:deoplete#enable_at_startup = 1
