#!/bin/bash

# utilities
function setup_directory()
{
    local _directory_=$1
    if [ "$_directory_" == "" ]; then
        echo "must pass directory name"
    elif [[ ! -d "$_directory_" ]]; then
        echo "setting up directory $_directory_"
        mkdir $_directory_
    fi
}

# initialization
set -e
cd ~/Base
echo "************ ENVIRONMENT SETUP COMMENCED ************"
setup_directory ~/Applications

# shell
if ! [ -d ~/.oh-my-zsh ]; then sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; fi
setup_directory ~/Applications/Shell
mv ~/.oh-my-zsh ~/Applications/Shell/
ln -sf ~/Base/config/dysonance.zsh-theme ~/Applications/Shell/.oh-my-zsh/themes/
ln -sf ~/Base/config/.zshrc ~/.zshrc

# environment initialization
if ! [ -f ~/environment.sh ]; then
    touch ~/environment.sh
    chmod +x ~/environment.sh
    echo "#!/usr/bin/env sh" >> ~/environment.sh
    echo "source ~/Base/config/environment.sh" >> 
    echo "export CPU=$(sysctl -n hw.ncpu)" >> ~/environment.sh
fi
if ! [ -f ~/.bash_profile ]; then touch ~/.bash_profile; fi
if [ "$(cat ~/.bash_profile | grep environment\\.sh)" = "" ]; then echo "source ~/environment.sh" >> ~/.bash_profile; fi
if ! [ -f ~/.zprofile ]; then touch ~/.zprofile; fi
if [ "$(cat ~/.zprofile | grep environment\\.sh)" = "" ]; then echo "source ~/environment.sh" >> ~/.zprofile; fi
if ! [ -f ~/.gitconfig ]; then touch ~/.gitconfig; fi
if [ "$(cat ~/.gitconfig | grep "include")" = "" ]; then echo "[include]\n    path = ~/Base/config/.gitconfig" >> ~/.gitconfig; fi
if ! [ -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "jamos125@gmail.com"
    echo "Host *\n    AddKeysToAgent yes\n    UseKeychain yes\n    IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config
    eval "$(ssh-agent -s)"
fi

# environment configurations
echo "setting up environment directories"
setup_directory ~/.vim
setup_directory ~/.config
setup_directory ~/.config/alacritty
setup_directory ~/.config/nvim
setup_directory ~/.matplotlib
setup_directory ~/.ipython
setup_directory ~/.ipython/profile_default
setup_directory ~/.psql_history
setup_directory ~/.tmux
setup_directory ~/.tmux/plugins
setup_directory ~/Library/R
setup_directory ~/Code
setup_directory ~/Code/Side
if ! [ -d ~/.tmux/plugins/tpm ]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
echo "linking configuration files"
ln -sf ~/Base/.vim/colors ~/.vim/colors
ln -sf ~/Base/.vim/syntax ~/.vim/syntax
ln -sf ~/Base/.vim/indent ~/.vim/indent
ln -sf ~/Base/.vim/skeletons ~/.vim/skeletons
ln -sf ~/Base/.vim/filetype.vim ~/.vim/
ln -sf ~/Base/.vim/plugins.vim ~/.vim/
ln -sf ~/Base/.vim/coc-settings.json ~/.vim/
ln -sf ~/Base/.vim/coc-settings.json ~/.config/nvim/
ln -sf ~/Base/config/.vimrc ~/.vimrc
ln -sf ~/Base/config/init.vim ~/.config/nvim/
ln -sf ~/Base/config/alacritty.yml ~/
ln -sf ~/Base/config/.tmux.conf ~/
ln -sf ~/Base/config/.tigrc ~/
ln -sf ~/Base/config/.psqlrc ~/
ln -sf ~/Base/config/ipython_config.py ~/.ipython/profile_default/
ln -sf ~/Base/config/.Rprofile ~/
ln -sf ~/Base/config/pylint.cfg ~/.config/
ln -sf ~/Base/config/flake8.cfg ~/.config/
ln -sf ~/Base/config/flake8.cfg /usr/local/share/
ln -sf ~/Base/config/.pg_format ~/.pg_format
ln -sf ~/Base/config/matplotlibrc ~/.matplotlib/

# install preliminary dependencies
echo "installing homebrew"
./src/dep/brew.sh > log/brew.log

# setup alacritty terminal
echo "installing alacritty"
./src/dep/alacritty.sh > log/alacritty.log

# setup python environment (required for vim and compatibility with other tech)
echo "installing python"
./src/dep/python.sh 3.8.7 > log/python3.log
./src/dep/python.sh 2.7.18 > log/python2.log

# setup vim environment
echo "installing vim"
./src/dep/vim.sh > log/vim.log
./src/dep/nvim.sh > log/nvim.log
echo "initializing vim package manager"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo "installing vim packages"
vim -c ":PlugInstall | :qa"

# finish logging
echo "************ ENVIRONMENT SETUP COMPLETED ************"
