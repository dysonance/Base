#!/bin/sh

JULIA_INSTALL_DIR=$HOME/Preferences/Applications/Julia

unset DYLD_LIBRARY_PATH
unset LD_LIBRARY_PATH

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

# # version 0.5
# cd $JULIA_INSTALL_DIR
# if [ ! -d "0.5" ]; then
#     git clone https://github.com/JuliaLang/julia.git 0.5
#     cd 0.5
#     git fetch --all
#     git checkout release-0.5
#     git pull
#     make -C deps getall && make -j $CPU && ./julia -e "Pkg.update()"
# else
#     cd 0.5
#     git pull
#     make -j $CPU && ./julia -e "Pkg.update()"
# fi

# version 0.6
cd $JULIA_INSTALL_DIR
if [ ! -d "v0.6" ]; then
    git clone https://github.com/JuliaLang/julia.git v0.6
    cd v0.6
    git fetch --all
    git checkout release-0.6
    git pull
    make -C deps getall && make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --compile=all --depwarn=no --optimize=3 --inline=yes -e "Pkg.update()"
else
    cd v0.6
    git pull
    make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --compile=all --optimize=3 --inline=yes --depwarn=no --quiet -e "Pkg.update()"
fi

# version 0.7 (pre-1.0 version)
cd $JULIA_INSTALL_DIR
if [ ! -d "v0.7" ]; then
    git clone https://github.com/JuliaLang/julia.git v0.7
    cd v0.7
    git fetch --all
    git checkout release-0.7
    git pull
    make -C deps getall && make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update()"
else
    cd v0.7
    git pull
    make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update()"
fi

# version 1.0
cd $JULIA_INSTALL_DIR
if [ ! -d "v1.0" ]; then
    git clone https://github.com/JuliaLang/julia.git v1.0
    cd v1.0
    git fetch --all
    git checkout release-1.0
    git pull
    make -C deps getall && make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update()"
else
    cd v1.0
    git pull
    make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update()"
fi

# current/lastest/nightly version
cd $JULIA_INSTALL_DIR
if [ ! -d "nightly" ]; then
    git clone https://github.com/JuliaLang/julia.git nightly
    cd nightly
    make -C deps getall && make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update()"
else
    cd nightly
    git pull
    make -j $CPU CFLAGS=-Wno-error && ./julia --color=yes --depwarn=no --warn-overwrite=no --optimize=3 --inline=yes -e "using Pkg; Pkg.update()"
fi

cd $JULIA_INSTALL_DIR
