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

# environment configurations
echo "setting up environment directories"
setup_directory ~/.vim
setup_directory ~/.config
setup_directory ~/.config/alacritty
setup_directory ~/.config/nvim
setup_directory ~/.ipython
setup_directory ~/.ipython/profile_default
setup_directory ~/.tmux
setup_directory ~/.tmux/plugins
setup_directory ~/Library/R
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

# install preliminary dependencies
echo "installing homebrew"
./src/dep/brew.sh > log/brew.log
brew tap homebrew/cask-fonts
brew cask install $(cat data/packages/required/fonts.txt)

# setup alacritty terminal
echo "installing alacritty"
./src/dep/alacritty.sh > log/alacritty.log

# setup llvm dep (required for later python 3 version configurations)
echo "installing llvm toolset"
./src/dep/llvm.sh > log/llvm.log

# setup python environment (required for vim and compatibility with other tech)
echo "installing python"
./src/dep/python.sh > log/python.log
ipi install $(cat data/python_packages.csv | sed "s/,.*$//g" | grep -v "package") >> log/python.log

# setup vim environment
echo "installing vim"
./src/dep/vim.sh > log/vim.log
echo "initializing vim package manager"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo "installing vim packages"
vim -c ":PlugInstall | :qa"

# finish logging
echo "************ ENVIRONMENT SETUP COMPLETED ************"
