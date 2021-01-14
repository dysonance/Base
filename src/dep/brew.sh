#!/bin/bash

BASEDIR=$HOME/Base
APPDIR=$HOME/Applications
if [ -x "$(command -v brew)" ]; then
    echo "brew already installed"
elif [ "$1" == "local" ]; then
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

BREW_PACKAGES=$(cat $BASEDIR/data/packages/brew.txt)
echo "===== BEGINNING BREW PACKAGE INSTALLATION ====="
brew tap homebrew/cask-fonts
brew install htop tmux reattach-to-user-namespace  # prioritize useful pkgs w/ quick installs
BREW_INSTALLED=$(brew list --formula)
for pkg in $BREW_PACKAGES; do
    if [ "$(brew list --formula | grep $pkg)" == "" ]; then
        echo "== installation attempt beginning: $pkg =="
        brew install $pkg --verbose
        echo "== installation attempt finished: $pkg =="
        BREW_INSTALLED=$(brew list --formula)
    else
        echo "== skipping unnecessary installation: $pkg =="
    fi
done
echo "===== BREW PACKAGE INSTALLATION FINISHED ====="
