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
jl --optimize=3 --warn-overwrite=no --depwarn=no --check-bounds=no --color=yes apps/julia/precompile.jl

# save package information
echo "package,version" > data/brew_packages.csv
brew list --full-name --versions | sed "s/ /,/g" >> data/brew_packages.csv
echo "package,version" > data/python_packages.csv
ipi list --format=freeze | sed "s/==/,/g" >> data/python_packages.csv
