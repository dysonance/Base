#!/bin/sh

INSTALL_DIRECTORY="$HOME/Preferences/apps/vim/vim"
PYTHON_VERSION="3.7.2_1"
PYTHON_CONFIG_DIR="/usr/local/Cellar/python/$PYTHON_VERSION/lib/pkgconfig"

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

if [ ! -d "$INSTALL_DIRECTORY" ]; then
    cd $INSTALL_DIRECTORY/..
    git clone https://github.com/vim/vim.git
    cd $INSTALL_DIRECTORY
else
    cd $INSTALL_DIRECTORY
fi

function BuildVim()
{
    ./configure \
        --enable-cscope \
        --enable-gui=no \
        --enable-luainterp \
        --enable-multibyte \
        --enable-perlinterp \
        --enable-python3interp \
        --enable-rubyinterp \
        --prefix=$INSTALL_DIRECTORY \
        --with-features=huge \
        --with-python-config-dir=$PYTHON_CONFIG_DIR \
        --with-python3-command=python3 \
        --without-x
    make -j $CPU
    make -j $CPU install
    cp src/ex bin/
    cp src/rview bin/
    cp src/rvim bin/
    cp src/view bin/
    cp src/vimdiff bin/
}

if [ "$1" == "--force" ]; then
    BuildVim
else
    git fetch
    LOCAL_COMMIT=$(git rev-parse @)
    REMOTE_COMMIT=$(git rev-parse "@{u}")
    if [ $LOCAL_COMMIT != $REMOTE_COMMIT ]; then
        git clean -xfd
        git pull
        BuildVim
    elif [[ ! -d "bin" ]]; then
        BuildVim
    fi
fi
