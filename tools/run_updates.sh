#!/bin/bash

cd $HOME/Preferences

brew update
brew upgrade
brew list --versions > data/brew_list.txt

vim -c ":PlugUpdate | :qa"

cd $HOME/.vim/plugged/YouCompleteMe
python3 install.py --all
cd -

cd $HOME/Applications/Julia
./update_julia.sh

cd $HOME/Preferences
