" neovim config file to be placed at the following location:
" ~/.config/nvim/init.vim
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
set runtimepath+=~/.local/share/nvim/site/autoload
set runtimepath+=~/.local/share/nvim/plugged
set runtimepath+=~/.vim
set runtimepath+=~/.vim/autoload/plug.vim
let &packpath = &runtimepath

" dependency paths
let g:ruby_host_prog="/usr/local/opt/ruby/bin/ruby"
let g:python_host_prog=$HOME."/.pyenv/versions/2.7.18/bin/python"
let g:python3_host_prog=$HOME."/.pyenv/versions/3.8.6/bin/python3"

source ~/.vimrc
