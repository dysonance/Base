#!/bin/bash

APP_DIRECTORY=$HOME/Applications
INSTALL_DIRECTORY=$APP_DIRECTORY/Vim/src

# for manual python source builds
PYTHON_VERSION=3.8.0
PYTHON_BINARY=$APP_DIRECTORY/Python/Versions/$PYTHON_VERSION/bin/python3
PYTHON_VERSION_SHORT="$(echo $PYTHON_VERSION | cut -c 1-3)"
PYTHON_CONFIG_DIR=$APP_DIRECTORY/Frameworks/Python.framework/Versions/$PYTHON_VERSION_SHORT/lib/python$PYTHON_VERSION_SHORT/config-${PYTHON_VERSION_SHORT}m-darwin

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

cd $APP_DIRECTORY
if ! [ -d "Vim" ]; then mkdir Vim; fi
cd $APP_DIRECTORY/Vim
if ! [ -d src ]; then git clone https://github.com/vim/vim.git src; fi
cd src

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
    echo "forcing rebuild of vim at commit"
    BuildVim
else
    git checkout master --quiet
    LOCAL_VERSION=$(git tag | tail -n 1)
    git pull --quiet
    LATEST_VERSION=$(git tag | tail -n 1)
    if [ "$LOCAL_VERSION" != "$LOCAL_VERSION" ]; then
        echo "updating vim from version $LOCAL_VERSION to $LATEST_VERSION"
        git checkout $LATEST_VERSION --quiet
        BuildVim
    else
        echo "vim is up-to-date at version $LOCAL_VERSION"
    fi
fi

# make `vi` point to same binary as vim
cd $APP_DIRECTORY/Vim/src/bin
ln -sf vim vi
