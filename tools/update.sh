#!/bin/bash

# entry
cd $HOME/Preferences

# packages
brew update
brew upgrade
brew list --versions > data/brew_list.txt
pip3 list --outdated --format=freeze sed 's/=*[0-9.]//g' | xargs -n1 pip3 install --upgrade
pip3 list > data/pip_list.txt

# vim
cd $HOME/Preferences/apps/vim
./deploy.sh
vim -c ":PlugUpdate | :qa"
cd $HOME/.vim/plugged/YouCompleteMe
python3 install.py --all
cd $HOME/Preferences

# julia
cd $HOME/Preferences/apps/julia
./deploy.sh

# end
cd $HOME/Preferences
