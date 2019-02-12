#!/bin/bash

# entry
cd $HOME/Preferences

# packages
brew update
brew upgrade
brew list --versions > data/brew_list.txt

# python
ipi list --outdated --format=freeze sed 's/=*[0-9.]//g' | xargs -n1 pip3 install --upgrade
ipi list > data/pip_list.txt

# alacritty
./apps/alacritty/deploy.sh

# vim
./apps/vim/deploy.sh
vim -c ":PlugUpdate | :qa"
py $HOME/.vim/plugged/YouCompleteMe/install.py --all

# julia
./apps/julia/deploy.sh
