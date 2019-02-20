#!/bin/bash

local _formula=$1
local _version=$2

if [ "$_formula" == "" ]; then
    echo "no formula supplied"
    exit 1
fi
if [ "$_version" == "" ]; then
    echo "no version supplied"
    exit 1
fi

cd $HOME/apps/brew/src/Library/Taps/homebrew/homebrew-core/Formula
git fetch --unshallow
COMMIT_STRING="$(git log --grep=$_version --oneline -n1 -- $_formula.rb)"
COMMIT_HASH="$(echo $COMMIT_STRING | awk '{print $1}')"

REMOTE_URL=$(git remote -v | head -n1 | awk '{print $2}')
RAW_URL="$(echo $REMOTE_URL | sed 's/github.com/raw.githubusercontent.com/')/$COMMIT_HASH/Formula/$_formula.rb"
brew install $RAW_URL
