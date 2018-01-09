#!/bin/sh

JULIA_INSTALL_DIR=$HOME/Applications/Julia

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

# version 0.5
cd $JULIA_INSTALL_DIR
if [ ! -d "0.5" ]; then
    git clone https://github.com/JuliaLang/julia.git 0.5
    cd 0.5
    git fetch --all
    git checkout release-0.5
    git pull
    make -C deps getall && make -j $CPU && ./julia -e "Pkg.update()"
else
    cd 0.5
    git pull
    make -j $CPU && ./julia -e "Pkg.update()"
fi

# version 0.6
cd $JULIA_INSTALL_DIR
if [ ! -d "0.6" ]; then
    git clone https://github.com/JuliaLang/julia.git 0.6
    cd 0.6
    git fetch --all
    git checkout release-0.6
    git pull
    make -C deps getall && make -j $CPU && ./julia -e "Pkg.update()"
else
    cd 0.6
    git pull
    make -j $CPU && ./julia -e "Pkg.update()"
fi

# current/nightly version
cd $JULIA_INSTALL_DIR
if [ ! -d "master" ]; then
    git clone https://github.com/JuliaLang/julia.git master
    cd master
    make -C deps getall && make -j $CPU && ./julia -e "Pkg.update()"
else
    cd master
    git pull
    make -j $CPU && ./julia -e "Pkg.update()"
fi

cd $JULIA_INSTALL_DIR


