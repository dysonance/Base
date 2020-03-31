#!/bin/bash

# entry
cd $HOME/Base

# expand aliases and define them
shopt -s expand_aliases
source ~/.bash_profile

# packages
brew update
brew upgrade

# alacritty
./src/dep/alacritty.sh

# python
ipi install --upgrade $(ipi list --format=freeze | sed 's/==/ /' | awk '{print $1}')

# vim
./src/dep/vim.sh
./src/dep/nvim.sh
vim -c ":PlugUpdate | :qa"

# julia
./src/dep/julia.sh

# save package information
echo "package,version" > data/packages/current/brew.csv
brew list --full-name --versions | sed "s/ /,/g" >> data/packages/current/brew.csv
echo "package,version" > data/packages/current/pip.csv
ipi list --format=freeze | sed "s/==/,/g" >> data/packages/current/pip.csv
