#!/bin/bash

# directory setup
cd $APPDIR
if ! [ -d "NeoVim" ]; then mkdir NeoVim; fi
cd NeoVim
if ! [ -d "src" ]; then git clone https://github.com/neovim/neovim src; fi
cd src

# version management
git clean -xfd
LOCAL_VERSION=$(git tag | tail -n 1)
git checkout master --quiet
git pull --quiet
LATEST_VERSION=$(git tag | tail -n 1)

# dependency configuration
export PATH=$APPDIR/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/3.9/bin:$PATH
DEPENDENCIES=(ninja libtool automake autoconf cmake pkg-config gettext lua luajit)
brew install $DEPENDENCIES

# build
PREFIX=$APPDIR/NeoVim/build
if ! [ -d $PREFIX ]; then mkdir $PREFIX; fi
make CMAKE_INSTALL_PREFIX=$PREFIX CMAKE_BUILD_TYPE=Release
make -j $CPU CMAKE_INSTALL_PREFIX=$PREFIX install
