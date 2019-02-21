#!/bin/bash

FORMULA=$1
VERSION=$2

if [ "$FORMULA" == "" ]; then
    echo "no formula supplied"
    exit 1
fi
if [ "$VERSION" == "" ]; then
    echo "no version supplied"
    exit 1
fi

cd $(brew --prefix)/Library/Taps/homebrew/homebrew-core/Formula

# check if shallow directory (history is missing)
# if so make it unshallow so the history can be searched
if [ -f $(git rev-parse --git-dir)/shallow ]; then
    git fetch --unshallow
fi
COMMIT_STRING="$(git log --grep=$VERSION --oneline -n1 -- $FORMULA.rb)"
COMMIT_HASH="$(echo $COMMIT_STRING | awk '{print $1}')"

REMOTE_URL=$(git remote -v | head -n1 | awk '{print $2}')
RAW_URL="$(echo $REMOTE_URL | sed 's/github.com/raw.githubusercontent.com/')/$COMMIT_HASH/Formula/$FORMULA.rb"
brew install $RAW_URL
