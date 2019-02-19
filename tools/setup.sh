#!/bin/bash

# install preliminary dependencies
brew install \
    make cmake \
    git wget \
    python go postgresql markdown pandoc \
    ctags tmux tree htop lnav \
    pgformatter shfmt clang-format

# define convenience function to create directory if it does not exist
function SetupDirectory()
{
    local _directory_=$1
    if [[ ! -d "$_directory_" ]]; then
        mkdir $_directory_
    fi
}

# link personal configuration files
ln -sf $HOME/Chest/config/.vimrc $HOME/
ln -sf $HOME/Chest/config/.gitconfig $HOME/
ln -sf $HOME/Chest/config/.Rprofile $HOME/
ln -sf $HOME/Chest/config/.tmux.conf $HOME/

# setup vim environment
cd $HOME/Chest/apps/vim
./deploy.sh
SetupDirectory $HOME/.vim
SetupDirectory $HOME/.vim/colors
SetupDirectory $HOME/.vim/syntax
ln -sf $HOME/Chest/.vim/colors/jamos_blue.vim $HOME/.vim/colors/
ln -sf $HOME/Chest/.vim/syntax/cpp.vim $HOME/.vim/syntax/
ln -sf $HOME/Chest/.vim/skeletons $HOME/.vim/
ln -sf $HOME/Chest/.vim/plugins.vim $HOME/.vim/
for syntax_file in $HOME/Chest/.vim/syntax/*.vim; do
    echo "linking $syntax_file to $HOME/.vim/syntax/"
    ln -sf $syntax_file $HOME/.vim/syntax/
done
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
vim -c ":PlugInstall | :PlugUpdate | :qa"
cd $HOME/.vim/plugged/YouCompleteMe
python3 install.py --all
cd $HOME/Chest

# setup python environment
pip3 install numpy pandas matplotlib ipython numba statsmodels scipy
SetupDirectory $HOME/.ipython
SetupDirectory $HOME/.ipython/profile_default
ln -sf $HOME/Chest/config/ipython_config.py $HOME/.ipython/profile_default/
