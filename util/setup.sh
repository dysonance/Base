#!/bin/bash

# initialization
set -e
cd ~/Base
echo "************ ENVIRONMENT SETUP COMMENCED ************"

# profile integration
if [ "$(grep 'Base/config/.bash_profile' ~/.bash_profile)" == "" ]; then
    echo "incorporating committed config into user bash profile"
    echo "creating backup copy of \`~/.bash_profile\` at \`/tmp/.bash_profile_backup\`"
    cp ~/.bash_profile /tmp/.bash_profile_backup
    echo '. ~/Base/config/.bash_profile' | cat - ~/.bash_profile > /tmp/tmp.sh &&
        echo "replacing \`~/.bash_profile\` with modified version" &&
        mv /tmp/tmp.sh ~/.bash_profile
fi
shopt -s expand_aliases
source ~/.bash_profile

# function definitions
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

# environment configurations
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
echo "installing homebrew"
./apps/brew/deploy.sh > log/brew.log
echo "installing brew packages"
BREW_PACKAGES=$(cat data/brew_packages.csv | sed "s/,.*$//g" | grep -v "package")
echo "===== BEGINNING BREW PACKAGE INSTALLATION =====" >> log/brew.log
brew install htop tmux reattach-to-user-namespace  # prioritize useful pkgs w/ quick installs
BREW_INSTALLED=$(brew list)
for pkg in $BREW_PACKAGES; do
    if [ "$(brew list | grep $pkg)" == "" ]; then
        echo "== installation attempt beginning: $pkg ==" >> log/brew.log
        brew install $pkg --verbose >> log/brew.log
        echo "== installation attempt finished: $pkg ==" >> log/brew.log
        BREW_INSTALLED=$(brew list)
    else
        echo "== skipping unnecessary installation: $pkg ==" >> log/brew.log
    fi
done
echo "===== BREW PACKAGE INSTALLATION FINISHED =====" >> log/brew.log

# setup alacritty terminal
echo "installing alacritty"
./apps/alacritty/deploy.sh > log/alacritty.log

# setup llvm environment (required for later python 3 version configurations)
echo "installing llvm toolset"
./apps/llvm/deploy.sh > log/llvm.log

# setup python environment (required for vim and compatibility with other tech)
echo "installing python"
./apps/python/deploy.sh > log/python.log
ipi install $(cat data/python_packages.csv | sed "s/,.*$//g" | grep -v "package") >> log/python.log

# setup vim environment
echo "installing vim"
./apps/vim/deploy.sh > log/vim.log
echo "initializing vim package manager"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo "installing vim packages"
vim -c ":PlugInstall | :qa"

# finish logging
echo "************ ENVIRONMENT SETUP COMPLETED ************"
