#!/bin/bash

cd $HOME/Base/apps/brew

HOMEBREW_REPO="https://github.com/Homebrew/brew"

if ! [ -d "src" ]; then
    git clone $HOMEBREW_REPO src
fi
cd src

./bin/brew update

ln -sf $HOME/Base/apps/brew/install-version.sh $HOME/Base/apps/brew/src/bin/brew-install-version
