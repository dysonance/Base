#!/bin/bash

# exit if an error occurs
set -e

# define variables/settings to build as desired
PYTHON_REPOSITORY="https://github.com/python/cpython"
FRAMEWORK_DIRECTORY=$HOME/Base/apps/frameworks

# define environment for dependencies
if ! [ -x "$(command -v openssl)" ]; then
    echo "installing dependency openssl"
    brew install openssl xz
fi
SSL_PATH=$(brew --prefix openssl)
SQLITE_PATH=$(brew --prefix sqlite)
ZLIB_PATH=$(brew --prefix zlib)
TK_PATH=$(brew --prefix tcl-tk)
export PKG_CONFIG_PATH=$SQLITE_PATH/lib/pkgconfig:$ZLIB_PATH/lib/pkgconfig:$TK_PATH/lib/pkgconfig:$SSL_PATH/lib/pkgconfig

# setup the required directory structure
cd $HOME/Base/apps/python
if ! [ -d "versions" ]; then
    mkdir versions
fi
if ! [ -d "versions/$PYTHON_VERSION" ]; then
    mkdir versions/$PYTHON_VERSION
fi
if ! [ -d "src" ]; then
    git clone "$PYTHON_REPOSITORY" src
fi

# get the appropriate version of the source code to build
cd src
git checkout master --quiet
git pull --quiet
if [ "$1" == "" ]; then
    PYTHON_VERSION=$(git tag | grep -v rc | grep -v "[ab][0-9]" | tail -n1 | sed 's/v//g')
else
    PYTHON_VERSION="$1"
fi

INSTALL_DIRECTORY="$HOME/Base/apps/python/versions/$PYTHON_VERSION"
export PYTHON_HOME=$INSTALL_DIRECTORY
echo "building python version $PYTHON_VERSION"
git checkout v$PYTHON_VERSION --quiet

# configure the installation (NOTE: configuration for versions < 3.7 is different)
export PATH=$SQLITE_PATH/bin:$PATH
export CC=clang
export LDFLAGS="-L$SQLITE_PATH/lib -L$ZLIB_PATH/lib -L$TK_PATH/lib -L$SSL_PATH/lib"
export CFLAGS="-I$SQLITE_PATH/include -I$ZLIB_PATH/include -I$TK_PATH/include -I$SSL_PATH/include"
git clean -xfd
./configure \
    --prefix=$INSTALL_DIRECTORY \
    --datadir=$INSTALL_DIRECTORY/share \
    --datarootdir=$INSTALL_DIRECTORY/share \
    --enable-framework=$FRAMEWORK_DIRECTORY \
    --enable-ipv6 \
    --enable-loadable-sqlite-extensions \
    --enable-optimizations \
    --with-dtrace \
    --with-lto \
    --with-openssl=$SSL_PATH \
    --without-ensurepip \
    --without-gcc
make -j $CPU
make frameworkinstallextras PYTHONAPPSDIR=$INSTALL_DIRECTORY/share/python
make install PYTHONAPPSDIR=$INSTALL_DIRECTORY

# create symbolic links to simplify version management
cd $INSTALL_DIRECTORY/..
if [ -d "current" ]; then
    rm current
fi
ln -sf $PYTHON_VERSION current

# install pip
cd $INSTALL_DIRECTORY/../..
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./versions/current/bin/python3 get-pip.py

# install python packages
cd $HOME/Base
PYTHON_PACKAGES=$(tail -n $(expr $(wc -l data/python_packages.csv | sed "s/[A-z \/\.]//g") - 1) data/python_packages.csv | sed s/,.*$//g)
cd apps/frameworks/Python.framework/Versions/Current/bin
./pip3 install $PYTHON_PACKAGES
