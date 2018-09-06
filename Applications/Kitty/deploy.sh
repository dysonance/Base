#!/bin/bash

KITTY_INSTALL_DIR=$HOME/Preferences/Applications/Kitty

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    dest=$KITTY_INSTALL_DIR \
    launch=n
