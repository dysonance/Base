#!/bin/sh

JULIA_INSTALL_DIR=$HOME/Preferences/apps/julia

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

# version 1.0
cd $JULIA_INSTALL_DIR
if [ ! -d "v1.0" ]; then
    git clone https://github.com/JuliaLang/julia.git v1.0
    cd v1.0
    git fetch --all
    git checkout release-1.0
    git pull
    cp ../Make.user .
    make -C deps getall && make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update(); Pkg.build()"
else
    cd v1.0
    git pull
    cp ../Make.user .
    make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update(); Pkg.build()"
fi

# current/latest/nightly version
cd $JULIA_INSTALL_DIR
if [ ! -d "nightly" ]; then
    git clone https://github.com/JuliaLang/julia.git nightly
    cd nightly
    cp ../Make.user .
    make -C deps getall && make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update(); Pkg.build()"
else
    cd nightly
    git pull
    cp ../Make.user .
    make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update(); Pkg.build()"
fi

cd $JULIA_INSTALL_DIR
