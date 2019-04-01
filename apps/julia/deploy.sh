#!/bin/sh

JULIA_INSTALL_DIR=$HOME/Chest/apps/julia

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

# current/latest/nightly version
cd $JULIA_INSTALL_DIR
if [ ! -d "src" ]; then
    git clone https://github.com/JuliaLang/julia.git src
    cd src
else
    cd src
    git pull
fi

if [ "$1" == "--clean" ]; then
    git clean -xfd
    make cleanall
fi

make -j $CPU
