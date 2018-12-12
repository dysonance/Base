#!/bin/bash

cd $HOME/Preferences

brew update
brew upgrade
brew list --versions > data/brew_list.txt
pip3 list > data/pip_list.txt

cd $HOME/Preferences/apps/vim
./install.sh

vim -c ":PlugUpdate | :qa"

cd $HOME/.vim/plugged/YouCompleteMe
python3 install.py --all
cd -

cd $HOME/Preferences/apps/julia
./update.sh

cd $HOME/Preferences
