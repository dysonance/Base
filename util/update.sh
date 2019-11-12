#!/bin/bash

# entry
cd $HOME/Base

# expand aliases and define them
shopt -s expand_aliases
source ~/.bash_profile

# packages
brew update
brew upgrade

# python
ipi install --upgrade $(ipi list --format=freeze | sed 's/==/ /' | awk '{print $1}')

# alacritty
./src/dep/alacritty.sh

# vim
./src/dep/vim.sh
vim -c ":PlugUpdate | :qa"
py $HOME/.vim/plugged/YouCompleteMe/install.py --all

# julia
./src/dep/julia.sh
julia --optimize=3 --warn-overwrite=no --depwarn=no --check-bounds=no --color=yes apps/julia/precompile.jl

# save package information
echo "package,version" > data/packages/current/brew.csv
brew list --full-name --versions | sed "s/ /,/g" >> data/packages/current/brew.csv
echo "package,version" > data/packages/current/pip.csv
ipi list --format=freeze | sed "s/==/,/g" >> data/packages/current/pip.csv
