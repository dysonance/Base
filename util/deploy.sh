#!/bin/bash

# stop and exit script at first error
set -e

# ensure starting directory and environment setup with aliases
cd ~/Base
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
ln -sf ~/Base/.vim/colors ~/.vim/colors
ln -sf ~/Base/.vim/syntax ~/.vim/syntax
ln -sf ~/Base/.vim/indent ~/.vim/indent
ln -sf ~/Base/.vim/filetype.vim ~/.vim/
ln -sf ~/Base/.vim/package.vim ~/.vim/
ln -sf ~/Base/config/.vimrc ~/.vimrc
ln -sf ~/Base/config/alacritty.yml ~/
ln -sf ~/Base/config/.tmux.conf ~/
ln -sf ~/Base/config/.Rprofile ~/
ln -sf ~/Base/config/.psqlrc ~/
ln -sf ~/Base/config/ipython_config.py ~/.ipython/profile_default/

# install preliminary dependencies
if [ "$(which brew)" == "" ]; then
    echo "installing homebrew"
    ./apps/brew/deploy.sh
fi
echo "installing brew packages"
brew install htop tmux reattach-to-user-namespace

BREW_PACKAGES=$(cat data/brew_packages.csv | sed "s/,.*$//g" | grep -v "package")
echo "===== BEGINNING BREW PACKAGE INSTALLATION =====" > log/brew_install.log
for pkg in $BREW_PACKAGES; do
    if [ "$(brew list | grep $pkg)" == "" ]; then
        echo "== installation attempt beginning: $pkg ==" >> log/brew_install.log
        brew install $pkg --verbose >> log/brew_install.log
        echo "== installation attempt finished: $pkg ==" >> log/brew_install.log
    else
        echo "== skipping unnecessary installation: $pkg ==" >> log/brew_install.log
    fi
done
echo "===== BREW PACKAGE INSTALLATION FINISHED =====" >> log/brew_install.log

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
