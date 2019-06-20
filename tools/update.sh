#!/bin/bash

# entry
cd $HOME/Chest

# expand aliases and define them
shopt -s expand_aliases
source ~/.bash_profile

# packages
brew update
brew upgrade

# python
ipi install --upgrade $(ipi list --format=freeze | sed 's/==/ /' | awk '{print $1}')

# alacritty
./apps/alacritty/deploy.sh

# vim
./apps/vim/deploy.sh
vim -c ":PlugUpdate | :qa"
py $HOME/.vim/plugged/YouCompleteMe/install.py --all

# julia
./apps/julia/deploy.sh
jl --optimize=3 --math-mode=fast --check-bounds=no --depwarn=no --color=yes apps/julia/precompile.jl
jln --optimize=3 --math-mode=fast --check-bounds=no --depwarn=no --color=yes apps/julia/precompile.jl
