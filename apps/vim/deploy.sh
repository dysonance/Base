#!/bin/sh

INSTALL_DIRECTORY="$HOME/Preferences/apps/vim/src"

# # for homebrew python installations
# PYTHON_VERSION="3.6.5_1"
# PYTHON_CONFIG_DIR="/usr/local/Cellar/python/$PYTHON_VERSION/lib/pkgconfig"
# PYTHON_BINARY=/usr/local/bin/python3

# # for manual python source builds
PYTHON_VERSION=3.6.5
PYTHON_BINARY=$HOME/Preferences/apps/python/versions/$PYTHON_VERSION/bin/python3
PYTHON_VERSION_SHORT="$(echo $PYTHON_VERSION | cut -c 1-3)"
PYTHON_CONFIG_DIR=$HOME/Preferences/apps/python/versions/$PYTHON_VERSION/lib/python$PYTHON_VERSION_SHORT/config-"$PYTHON_VERSION_SHORT"dm-darwin
# #PYTHON_CONFIG_DIR=$HOME/Preferences/apps/python/versions/$PYTHON_VERSION/lib/pkgconfig

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

if [ ! -d "$INSTALL_DIRECTORY" ]; then
    cd $INSTALL_DIRECTORY/..
    git clone https://github.com/vim/vim.git src
    cd $INSTALL_DIRECTORY
else
    cd $INSTALL_DIRECTORY
fi

function BuildVim()
{

    make clean
    if [ -f src/auto/config.cache ]; then
        rm src/auto/config.cache
    fi

    ./configure \
        --prefix=$INSTALL_DIRECTORY \
        --with-features=huge \
        --enable-cscope=yes \
        --enable-gui=no \
        --enable-luainterp=yes \
        --enable-multibyte=yes \
        --enable-perlinterp=yes \
        --enable-rubyinterp=yes \
        --enable-python3interp=yes \
        --with-python-config-dir=$PYTHON_CONFIG_DIR \
        --with-python3-command=$PYTHON_BINARY \
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

# backup vim binary if build succeeds to prevent losing it later
if ! [ -d "$HOME/Preferences/apps/vim/bin" ]; then
    mkdir $HOME/Preferences/apps/vim/bin
fi
cp bin/* $HOME/Preferences/apps/vim/bin/
