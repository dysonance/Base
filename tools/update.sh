#!/bin/bash

# entry
cd $HOME/Chest

# packages
brew update
brew upgrade

# python
ipi install --upgrade $(pip list --format=freeze | sed 's/==/ /' | awk '{print $1}')

# alacritty
./apps/alacritty/deploy.sh

# vim
./apps/vim/deploy.sh
vim -c ":PlugUpdate | :qa"
py $HOME/.vim/plugged/YouCompleteMe/install.py --all

# julia
./apps/julia/deploy.sh
julia -g2 --color=yes apps/julia/precompile.jl
