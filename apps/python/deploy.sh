#!/bin/bash

# exit if an error occurs
set -e

# define variables/settings to build as desired
PYTHON_VERSION="3.6.5"
PYTHON_REPOSITORY="https://github.com/python/cpython"
INSTALL_DIRECTORY=$HOME/Preferences/apps/python/versions/$PYTHON_VERSION

# define environment for dependencies
if ! [ -x "$(command -v openssl)" ]; then
    echo "installing dependency openssl"
    brew install openssl xz
fi
SSL_DIRECTORY=$(brew --prefix openssl)

# setup the required directory structure
cd $INSTALL_DIRECTORY/../..
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
if [ "$(echo $PYTHON_VERSION | cut -c 1-3)" == "3.7" ]; then
    ./configure \
        --prefix=$INSTALL_DIRECTORY \
        --enable-optimizations \
        --with-openssl=$SSL_DIRECTORY
else
    CPPFLAGS="-I$SSL_DIRECTORY/include" \
    LDFLAGS="-L$SSL_DIRECTORY/lib" \
        ./configure \
            --prefix=$INSTALL_DIRECTORY \
            --enable-optimizations
fi

# allow parallel make
if [ -z "$CPU" ]; then
    CPU=4
fi

# run the build
make -j $CPU install

# create symbolic links to simplify version management
cd $INSTALL_DIRECTORY/..
if [ -d "current" ]; then
    rm current
fi
ln -sf $PYTHON_VERSION current
