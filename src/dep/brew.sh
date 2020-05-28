#!/bin/bash

BASEDIR=$HOME/Base
APPDIR=$HOME/Applications
if [ "$1" == "local" ]; then
    # custom local/user directory environment
    HOMEBREW_REPO="https://github.com/Homebrew/brew"
    if ! [ -d "$APPDIR/Brew" ]; then mkdir $APPDIR/Brew; fi
    cd $APPDIR/Brew
    if ! [ -d "src" ]; then git clone $HOMEBREW_REPO src; fi
    export PATH=$APPDIR/Brew/src/bin/brew:$PATH
else
    # default installation using command from https://brew.sh/
    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# fetch current versions for brew and all packages
brew update

BREW_PACKAGES=$(cat $BASEDIR/data/packages/required/brew.csv)
echo "===== BEGINNING BREW PACKAGE INSTALLATION ====="
brew install htop tmux reattach-to-user-namespace  # prioritize useful pkgs w/ quick installs
BREW_INSTALLED=$(brew list)
for pkg in $BREW_PACKAGES; do
    if [ "$(brew list | grep $pkg)" == "" ]; then
        echo "== installation attempt beginning: $pkg =="
        brew install $pkg --verbose
        echo "== installation attempt finished: $pkg =="
        BREW_INSTALLED=$(brew list)
    else
        echo "== skipping unnecessary installation: $pkg =="
    fi
done
echo "===== BREW PACKAGE INSTALLATION FINISHED ====="
