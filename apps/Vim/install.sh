#!/bin/sh

INSTALL_DIRECTORY="$HOME/Preferences/Applications/Vim"

if [ ! -d "$INSTALL_DIRECTORY" ]; then
    git clone https://github.com/vim/vim.git $INSTALL_DIRECTORY
    cd $INSTALL_DIRECTORY
else
    cd $INSTALL_DIRECTORY
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
            --prefix=$INSTALL_DIRECTORY

make

make install \
    DESTDIR=vim \
    VIMRUNTIMEDIR=$INSTALL_DIRECTORY/runtime

