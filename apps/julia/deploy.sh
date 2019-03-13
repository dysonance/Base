#!/bin/sh

JULIA_INSTALL_DIR=$HOME/Chest/apps/julia

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

# current/latest/nightly version
cd $JULIA_INSTALL_DIR
if [ ! -d "nightly" ]; then
    git clone https://github.com/JuliaLang/julia.git nightly
    cd nightly
    cp ../Make.user .
else
    cd nightly
    git pull
    cp ../Make.user .
fi

if [ "$1" == "--clean" ]; then
    git clean -xfd
    make cleanall
    cp ../Make.user .
fi

make -C deps getall && make -j $CPU CFLAGS=-Wno-error

# NOTE: sometimes the following warning will appear
# libtool: warning: remember to run 'libtool --finish /Users/JAmos/Chest/apps/julia/nightly/usr/lib'
