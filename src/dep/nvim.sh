#!/bin/bash

# directory setup
cd $APPDIR
if ! [ -d "NeoVim" ]; then mkdir NeoVim; fi
cd NeoVim
if ! [ -d "src" ]; then git clone https://github.com/neovim/neovim src; fi
cd src

# version management
LOCAL_VERSION=$(git tag | tail -n 1)
git checkout master --quiet
git pull --quiet
LATEST_VERSION=$(git tag | tail -n 1)

# dependency configuration
export PATH=$APPDIR/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/3.8/bin:$PATH
BREW_DEPENDENCIES=(ninja libtool automake cmake pkg-config gettext)
BREW_INSTALLED=$(brew list)
for dep in "${BREW_DEPENDENCIES[@]}"; do
    echo "setting up dependency: $dep"
    if [ "$(echo $BREW_INSTALLED | grep $dep)" == "" ]; then
        echo "\tinstalling $dep since not currently installed"
        brew install $dep
    fi
done

# build
if ! [ -d "build" ]; then mkdir build; fi
#cd build
make CMAKE_INSTALL_PREFIX=$(pwd)/build CMAKE_BUILD_TYPE=Release
make install
