#!/bin/bash

cd $HOME/Preferences/apps/brew

if ! [ -d "src" ]; then
    mkdir src
fi
cd src

if ! [ -d "homebrew-core" ]; then
    git clone https://github.com/Homebrew/homebrew-core
fi

if ! [ -d "brew" ]; then
    git clone https://github.com/Homebrew/brew
fi

cd homebrew-core
