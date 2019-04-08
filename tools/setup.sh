#!/bin/bash

# ensure starting directory and environment setup with aliases
cd ~/Chest
shopt -s expand_aliases
source ~/.bash_profile

# define convenience function to create directory if it does not exist
function SetupDirectory()
{
    local _directory_=$1
    if [ "$_directory_" == "" ]; then
        echo "must pass directory name"
    elif [[ ! -d "$_directory_" ]]; then
        mkdir $_directory_
    fi
}

# install preliminary dependencies
./apps/brew/deploy.sh
brew install $(cat data/brew_list.txt)

# setup llvm environment (required for later python 3 version configurations)
./apps/llvm/deploy.sh

# setup python environment (required for vim and compatibility with other tech)
./apps/python/deploy.sh
./apps/python/deploy.sh 3.6.5
pip36 install data/pip_list.txt
ipi install data/pip_list.txt
SetupDirectory ~/.ipython
SetupDirectory ~/.ipython/profile_default
ln -sf ~/Chest/config/ipython_config.py ~/.ipython/profile_default/

# setup vim environment
./apps/vim/deploy.sh
SetupDirectory ~/.vim
SetupDirectory ~/.vim/colors
SetupDirectory ~/.vim/syntax
ln -sf ~/Chest/.vim/colors/* ~/.vim/colors/
ln -sf ~/Chest/.vim/syntax/* ~/.vim/syntax/
ln -sf ~/Chest/.vim/indent/* ~/.vim/indent/
ln -sf ~/Chest/.vim/filetype.vim ~/.vim/
ln -sf ~/Chest/.vim/package.vim ~/.vim/
ln -sf ~/Chest/config/.vimrc ~/.vimrc
# install vim plugged package manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
vim -c ":PlugInstall | :qa"

# setup alacritty terminal
./apps/alacritty/deploy.sh

# put configuration files in the right places
SetupDirectory ~/.config
SetupDirectory ~/.config/alacritty
ln -sf ~/Chest/config/alacritty.yml ~/
ln -sf ~/Chest/config/.tmux.conf ~/
ln -sf ~/Chest/config/.Rprofile ~/
ln -sf ~/Chest/config/.psqlrc ~/
