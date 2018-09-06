#!/bin/bash

KITTY_INSTALL_DIR="$HOME/Preferences/Applications/Kitty"

cd $KITTY_INSTALL_DIR
if [ ! -d "src" ]; then
    git clone https://github.com/kovidgoyal/kitty src
fi
cd src
git pull
make -j $CPU
cd $KITTY_INSTALL_DIR
