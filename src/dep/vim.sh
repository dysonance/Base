#!/bin/bash

INSTALL_DIRECTORY=$APPDIR/Vim/src

# for manual python source builds
PYTHON_VERSION=$(python3 -V | sed 's/Python //g')
PYTHON_BINARY=$APPDIR/Python/Versions/$PYTHON_VERSION/bin/python3
PYTHON_VERSION_SHORT="$(echo $PYTHON_VERSION | cut -c 1-3)"
PYTHON_CONFIG_DIR=$APPDIR/Frameworks/Python.framework/Versions/$PYTHON_VERSION_SHORT/lib/python$PYTHON_VERSION_SHORT/config-${PYTHON_VERSION_SHORT}m-darwin

cd $APPDIR
if ! [ -d "Vim" ]; then mkdir Vim; fi
cd $APPDIR/Vim
if ! [ -d src ]; then git clone https://github.com/vim/vim.git src; fi
if ! [ -d bin ]; then mkdir bin; fi
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
    if [[ -z "${CPU}" ]]; then CPU=4; fi
    make -j $CPU
    make -j $CPU install
    cp bin/ex ../bin/
    cp bin/rview ../bin/
    cp bin/rvim ../bin/
    cp bin/view ../bin/
    cp bin/vimdiff ../bin/
    cp bin/vim ../bin/
}

if [ "$1" == "--force" ]; then
    echo "forcing rebuild of vim at commit"
    BuildVim
else
    git checkout master --quiet
    LOCAL_VERSION=$(git rev-parse HEAD)
    git pull --quiet
    LATEST_VERSION=$(git rev-parse $(git tag | tail -n 1))
    if [ "$LOCAL_VERSION" != "$LOCAL_VERSION" ]; then
        echo "updating vim from version $LOCAL_VERSION to $LATEST_VERSION"
        git checkout $LATEST_VERSION --quiet
        BuildVim
    else
        echo "vim is up-to-date at version $LOCAL_VERSION"
    fi
fi

# make `vi` point to same binary as vim
cd $APPDIR/Vim/bin
ln -sf vim vi
