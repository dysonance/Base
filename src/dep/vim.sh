#!/bin/bash

# build environment parameters
PREFIX=$APPDIR/Vim
# python 2
PY2_PREFIX=$(python2 -c 'import sys; print(sys.prefix)')
PY2_COMMAND=$PY2_PREFIX/bin/python2
PY2_VERSION=$($PY2_COMMAND -c "import sys; print(sys.prefix.split('/')[-1])")
PY2_CONFDIR=$PY2_PREFIX/lib/python$PY2_VERSION/config-${PY2_VERSION}-darwin
# python 3
PY3_PREFIX=$(python3 -c 'import sys; print(sys.prefix)')
PY3_COMMAND=$PY3_PREFIX/bin/python3
PY3_VERSION=$($PY3_COMMAND -c "import sys; print(sys.prefix.split('/')[-1])")
PY3_CONFDIR=$PY3_PREFIX/lib/python$PY3_VERSION/config-${PY3_VERSION}-darwin
# ruby
RUBY_COMMAND=/usr/local/opt/ruby/bin/ruby


cd $APPDIR
if ! [ -d "Vim" ]; then mkdir Vim; fi
cd $APPDIR/Vim
if ! [ -d src ]; then git clone https://github.com/vim/vim.git src; fi
cd src

function BuildVim()
{
    make clean
    if [ -f src/auto/config.cache ]; then rm src/auto/config.cache; fi
    ./configure \
        --prefix=$PREFIX \
        --with-features=huge \
        --enable-cscope=yes \
        --enable-gui=no \
        --enable-luainterp=yes \
        --enable-multibyte=yes \
        --enable-perlinterp=yes \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --enable-python3interp=yes \
        --with-python-config-dir=$PY2_CONFDIR \
        --with-python3-config-dir=$PY3_CONFDIR \
        --with-python-command=$PY2_COMMAND \
        --with-python3-command=$PY3_COMMAND \
        --with-ruby-command=$RUBY_COMMAND \
        --without-x
    if [[ -z "${CPU}" ]]; then CPU=$(sysctl -n hw.ncpu); fi
    make -j $CPU
    make -j $CPU install
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
