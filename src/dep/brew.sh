#!/bin/bash

BASEDIR=$HOME/Base
APPDIR=$HOME/Applications
HOMEBREW_REPO="https://github.com/Homebrew/brew"

if ! [ -d "$APPDIR/Brew" ]; then mkdir $APPDIR/Brew; fi
cd $APPDIR/Brew
if ! [ -d "src" ]; then git clone $HOMEBREW_REPO src; fi
cd src

./bin/brew update

BREW_PACKAGES=$(cat $BASEDIR/data/packages/required//brew.csv | sed "s/,.*$//g" | grep -v "package")
echo "===== BEGINNING BREW PACKAGE INSTALLATION ====="
brew install htop tmux reattach-to-user-namespace  # prioritize useful pkgs w/ quick installs
BREW_INSTALLED=$(./bin/brew list)
for pkg in $BREW_PACKAGES; do
    if [ "$(./bin/brew list | grep $pkg)" == "" ]; then
        echo "== installation attempt beginning: $pkg =="
        ./bin/brew install $pkg --verbose
        echo "== installation attempt finished: $pkg =="
        BREW_INSTALLED=$(./bin/brew list)
    else
        echo "== skipping unnecessary installation: $pkg =="
    fi
done
echo "===== BREW PACKAGE INSTALLATION FINISHED ====="
