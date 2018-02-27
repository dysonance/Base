#!/bin/bash

brew update
brew upgrade

vim -c ":PlugUpdate | :qa"

cd $HOME/.vim/plugged/YouCompleteMe
./install.py --all
cd -

cd $HOME/Applications/Julia
./update_julia.sh

cd $HOME/Preferences
