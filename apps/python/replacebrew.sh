#!/bin/bash

APP_DIRECTORY=$HOME/Base/apps
BREW_VERSION=3.6.5_1

if [ -d /usr/local/Cellar/python/$BREW_VERSION ]; then
    if ! [ -d "/usr/local/Cellar/python/$BREW_VERSION-brew" ]; then
        mv /usr/local/Cellar/python/$BREW_VERSION /usr/local/Cellar/python/$BREW_VERSION-brew
    fi
fi
mkdir /usr/local/Cellar/python/$BREW_VERSION
mkdir /usr/local/Cellar/python/$BREW_VERSION/Frameworks
ln -sf $APP_DIRECTORY/frameworks/Python.framework /usr/local/Cellar/python/$BREW_VERSION/Frameworks/Python.framework
