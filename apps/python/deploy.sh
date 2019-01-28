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
CPPFLAGS="-I$SSL_DIRECTORY/include"
LDFLAGS="-L$SSL_DIRECTORY/lib"

# setup the required directory structure
if ! [ -d "versions" ]; then
    mkdir versions
fi
if ! [ -d "versions/$PYTHON_VERSION" ]; then
    mkdir versions/$PYTHON_VERSION
fi
if ! [ -d "python" ]; then
    git clone "$PYTHON_REPOSITORY" python
fi

# get the appropriate version of the source code to build
cd python
git checkout v$PYTHON_VERSION

# configure the installation
CPPFLAGS="-I$SSL_DIRECTORY/include" \
LDFLAGS="-L$SSL_DIRECTORY/lib" \
    ./configure \
        --prefix=$INSTALL_DIRECTORY \
        --enable-optimizations \
        --with-pydebug \
        --with-openssl=$(brew --prefix openssl)

# allow parallel make
if [ -z "$CPU" ]; then
    CPU=4
fi

# run the build
make -j $CPU
make -j $CPU install

# create symbolic links to simplify version management
ln -sf $INSTALL_DIRECTORY $INSTALL_DIRECTORY/../current
