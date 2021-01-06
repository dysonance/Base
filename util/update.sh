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
