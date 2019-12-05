#!/bin/bash

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
    cp -r target/release/osx/Alacritty.app $HOME/Applications
else
    git fetch
    ALACRITTY_VERSION=$(git tag | tail -n 1)
    CURRENT_COMMIT=$(git rev-parse @)
    VERSION_COMMIT=$(git rev-list -n 1 $ALACRITTY_VERSION)
    if [ $LOCAL_COMMIT != $REMOTE_COMMIT ]; then
        git checkout $ALACRITTY_VERSION
        make -j $CPU app
        cp -r target/release/osx/Alacritty.app $HOME/Applications
    fi
fi

if ! [ -d "$HOME/.config/alacritty" ]; then
    echo "creating alacritty directory in ~/.config"
    mkdir $HOME/.config/alacritty
fi
ln -sf $HOME/Base/config/alacritty.yml $HOME/.config/alacritty/alacritty.yml

if [ -d $APPDIR/Alacritty.app ]; then
    if [ -d $APPDIR/Alacritty/Alacritty.app ]; then
        rm -rf $APPDIR/Alacritty/Alacritty.app
    fi
    mv $APPDIR/Alacritty.app $APPDIR/Alacritty/Alacritty.app
fi
