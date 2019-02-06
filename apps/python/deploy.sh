#!/bin/bash

# exit if an error occurs
set -e

# define variables/settings to build as desired
PYTHON_VERSION="3.6.5"
PYTHON_REPOSITORY="https://github.com/python/cpython"
INSTALL_DIRECTORY=$HOME/Preferences/apps/python/versions/$PYTHON_VERSION
FRAMEWORK_DIRECTORY=$HOME/Preferences/apps/frameworks

# define environment for dependencies
if ! [ -x "$(command -v openssl)" ]; then
    echo "installing dependency openssl"
    brew install openssl xz
fi
SSL_DIRECTORY=$(brew --prefix openssl)

# setup the required directory structure
cd $HOME/Preferences/apps/python
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
git checkout v$PYTHON_VERSION

# configure the installation
# NOTE: configuration for versions < 3.7 is different
# FIXME: installing as a framework (req for vim YCM plugin) is all messed up

if [ "$(echo $PYTHON_VERSION | cut -c 1-3)" == "3.7" ]; then

    make clean
    ./configure \
        --prefix=$INSTALL_DIRECTORY \
        --enable-framework=$FRAMEWORK_DIRECTORY \
        --enable-optimizations \
        --with-openssl=$SSL_DIRECTORY

else

    make clean
    export CPPFLAGS="-I$SSL_DIRECTORY/include -I/usr/local/include -I/usr/local/opt/zlib/include"
    export LDFLAGS="-L$SSL_DIRECTORY/lib -L/usr/local/lib -L/usr/local/opt/zlib/lib"
        ./configure \
            --prefix=$INSTALL_DIRECTORY \
            --datarootdir=$INSTALL_DIRECTORY/share \
            --datadir=$INSTALL_DIRECTORY/share \
            --enable-framework=$FRAMEWORK_DIRECTORY \
            --enable-loadable-sqlite-extensions \
            --enable-ipv6 \
            --enable-optimizations \
            --with-dtrace \
            --without-ensurepip \
            --without-gcc \
            CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS"

fi

# run the build
make -j $CPU
make -j $CPU install PYTHONAPPSDIR=$INSTALL_DIRECTORY
make -j $CPU frameworkinstallextras PYTHONAPPSDIR=$INSTALL_DIRECTORY/share/python

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

if [ "$1" == "--overwrite-brew" ]; then
    if [ -d /usr/local/Cellar/python/3.6.5_1 ]; then
        if ! [ -d "/usr/local/Cellar/python/3.6.5_1-brew" ]; then
            mv /usr/local/Cellar/python/3.6.5_1 /usr/local/Cellar/python/3.6.5_1-brew
        fi
    fi
    mkdir /usr/local/Cellar/python/3.6.5_1
    mkdir /usr/local/Cellar/python/3.6.5_1/Frameworks
    ln -sf $HOME/Preferences/apps/frameworks/Python.framework /usr/local/Cellar/python/3.6.5_1/Frameworks/Python.framework
fi
