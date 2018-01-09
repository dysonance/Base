#!/bin/sh

VIM_INSTALL_DIRECTORY="$HOME/Applications/Vim"

if [ ! -d "$VIM_INSTALL_DIRECTORY" ]; then
    git clone https://github.com/vim/vim.git $VIM_INSTALL_DIRECTORY
    cd $VIM_INSTALL_DIRECTORY
else
    cd $VIM_INSTALL_DIRECTORY
    git clean -xfd
    git pull
fi

./configure --with-features=huge \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-pythoninterp \
            --enable-multibyte \
            --enable-perlinterp \
            --enable-rubyinterp \
            --enable-luainterp \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=$VIM_INSTALL_DIRECTORY

make 

make install \
    DESTDIR=vim \
    VIMRUNTIMEDIR=$VIM_INSTALL_DIRECTORY/runtime

