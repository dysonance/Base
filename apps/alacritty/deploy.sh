#!/bin/bash

cd $HOME/Preferences/apps/alacritty

# download source
if ! [ -d "src" ]; then
    REPO="https://github.com/jwilm/alacritty"
    git clone $REPO src
fi
cd src
git pull

# build and save to applications
make app
cp -r target/release/osx/Alacritty.app $HOME/Applications

if ! [ -d "$HOME/.config/alacritty" ]; then
    echo "creating alacritty directory in ~/.config"
    mkdir $HOME/.config/alacritty
fi
ln -sf $HOME/Preferences/config/alacritty.yml $HOME/.config/alacritty/alacritty.yml
