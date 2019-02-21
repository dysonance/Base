#!/bin/bash

cd $HOME/Chest/apps/brew

HOMEBREW_REPO="https://github.com/Homebrew/brew"

if ! [ -d "src" ]; then
    git clone $HOMEBREW_REPO src
fi
cd src

./bin/brew update

ln -sf $HOME/Chest/apps/brew/install-version.sh $HOME/Chest/apps/brew/src/bin/brew-install-version
