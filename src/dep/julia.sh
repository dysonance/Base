#!/bin/bash

REPO="https://github.com/JuliaLang/julia.git"

cd $APPDIR
if ! [ -d "Julia" ]; then mkdir Julia; fi
cd Julia
if ! [ -d "src" ]; then git clone $REPO src; fi
cd src

git checkout master
git pull
git checkout $(git tag | tail -n 1)
if [ "$1" == "--clean" ]; then
    git clean -xfd
    make cleanall
fi

if [[ -z "${CPU}" ]]; then CPU=4; fi
unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH
make -j $CPU
