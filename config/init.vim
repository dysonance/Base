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
let g:ruby_host_prog=$HOME."/Applications/Brew/src/opt/ruby/bin/ruby"
let g:python_host_prog=$HOME."/Applications/Frameworks/Python.framework/Versions/2.7/bin/python"
let g:python3_host_prog=$HOME."/Applications/Frameworks/Python.framework/Versions/3.8/bin/python3"

source ~/.vimrc
