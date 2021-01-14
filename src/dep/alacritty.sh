#!/bin/bash

APPDIR=$HOME/Applications
cd $APPDIR
if ! [ -d "Alacritty" ]; then mkdir Alacritty; fi
cd Alacritty

# dependency management
DEPENDENCIES=(make rust)
for dep in "${DEPENDENCIES[@]}"; do echo "installing dependency: $dep" && brew install $dep; done

# download source
REPO="https://github.com/jwilm/alacritty"
if ! [ -d "src" ]; then git clone $REPO src; fi
cd src

if [[ -z "${CPU}" ]]; then CPU=4; fi

# build and save to applications
if [ "$1" == "--force" ]; then
    make -j $CPU app
    mv target/release/osx/Alacritty.app $APPDIR/Alacritty/
else
    CURRENT_COMMIT=$(git rev-parse @)
    git checkout master
    git pull
    BUILD_VERSION=$(git tag | grep -v rc | tail -n 1)
    git checkout $BUILD_VERSION
    LATEST_COMMIT=$(git rev-parse @)
    if [ $CURRENT_COMMIT != $LATEST_COMMIT ]; then
        make -j $CPU app
        mv target/release/osx/Alacritty.app $APPDIR/Alacritty/Alacritty.app
    fi
fi

if ! [ -d "$HOME/.config/alacritty" ]; then
    echo "creating alacritty directory in ~/.config"
    mkdir $HOME/.config/alacritty
fi
ln -sf $HOME/Base/config/alacritty.yml $HOME/.config/alacritty/alacritty.yml
