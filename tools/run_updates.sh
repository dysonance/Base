#!/bin/bash

cd $HOME/Preferences

brew update
brew upgrade
brew list > brew_list.txt

vim -c ":PlugUpdate | :qa"

cd $HOME/.vim/plugged/YouCompleteMe
./install.py --all
cd -

cd $HOME/Applications/Julia
./update_julia.sh

cd $HOME/Preferences
