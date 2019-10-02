#!/bin/bash

# stop and exit script at first error
set -e

# ensure starting directory and environment setup with aliases
cd ~/Chest
shopt -s expand_aliases
source ~/.bash_profile

# convenience function to create directory if it does not exist
function SetupDirectory()
{
    local _directory_=$1
    if [ "$_directory_" == "" ]; then
        echo "must pass directory name"
    elif [[ ! -d "$_directory_" ]]; then
        echo "setting up directory $_directory_"
        mkdir $_directory_
    fi
}

# setup environment configurations/preferences
echo "setting up environment directories"
SetupDirectory ~/.vim
SetupDirectory ~/.config
SetupDirectory ~/.config/alacritty
SetupDirectory ~/.ipython
SetupDirectory ~/.ipython/profile_default
echo "linking configuration files"
ln -sf ~/Chest/.vim/colors ~/.vim/colors
ln -sf ~/Chest/.vim/syntax ~/.vim/syntax
ln -sf ~/Chest/.vim/indent ~/.vim/indent
ln -sf ~/Chest/.vim/filetype.vim ~/.vim/
ln -sf ~/Chest/.vim/package.vim ~/.vim/
ln -sf ~/Chest/config/.vimrc ~/.vimrc
ln -sf ~/Chest/config/alacritty.yml ~/
ln -sf ~/Chest/config/.tmux.conf ~/
ln -sf ~/Chest/config/.Rprofile ~/
ln -sf ~/Chest/config/.psqlrc ~/
ln -sf ~/Chest/config/ipython_config.py ~/.ipython/profile_default/

# install preliminary dependencies
if [ "$(which brew)" == "" ]; then
    echo "installing homebrew"
    ./apps/brew/deploy.sh
fi
echo "installing brew packages"
brew install htop tmux reattach-to-user-namespace
brew install $(cat data/brew_packages.csv | sed "s/,.*$//g" | grep -v "package")

# setup alacritty terminal
echo "installing alacritty"
./apps/alacritty/deploy.sh

# setup llvm environment (required for later python 3 version configurations)
echo "installing llvm toolset"
./apps/llvm/deploy.sh

# setup python environment (required for vim and compatibility with other tech)
echo "installting python (latest)"
./apps/python/deploy.sh
echo "installing python (3.6.5)"
./apps/python/deploy.sh 3.6.5
echo "installing python packages"
pip36 install $(cat data/python_packages.csv | sed "s/,.*$//g" | grep -v "package")
ipi install $(cat data/python_packages.csv | sed "s/,.*$//g" | grep -v "package")

# setup vim environment
echo "installing vim"
./apps/vim/deploy.sh
echo "initializing vim package manager"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo "installing vim packages"
vim -c ":PlugInstall | :qa"
