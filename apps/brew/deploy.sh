#!/bin/bash

cd $HOME/Chest/apps/brew

if ! [ -d "src" ]; then
    mkdir src
    git clone https://github.com/Homebrew/brew src
fi
cd src

./bin/brew update

cd ..
if ! [ -d "$HOME/Chest/apps/brew/bin" ]; then
    mkdir bin
fi
ln -sf $HOME/Chest/apps/brew/src/bin/* $HOME/Chest/apps/brew/bin/
ln -sf $HOME/Chest/apps/brew/install-version.sh $HOME/Chest/apps/brew/bin/brew-install-version
