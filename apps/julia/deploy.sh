#!/bin/bash

JULIA_INSTALL_DIR=$HOME/Chest/apps/julia

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

cd $JULIA_INSTALL_DIR
if [ ! -d "src" ]; then
    git clone https://github.com/JuliaLang/julia.git src
fi
cd src
git checkout master
git pull
git checkout $(git tag | tail -n 1)

if [ "$1" == "--clean" ]; then
    git clean -xfd
    make cleanall
fi

make -j $CPU
