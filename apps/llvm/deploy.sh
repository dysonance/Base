#!/bin/bash

# Note: See this anser on StackOverflow for a good explanation of how this needs to be structured
# https://stackoverflow.com/a/49702159/2271756

SYSTEM_HEADER_LOCATION=/usr/include/c++/4.2.1
INSTALL_LOCATION=$HOME/Base/apps/llvm
LLVM_VERSION=9.0.0

cd $INSTALL_LOCATION

if [ -d "src" ]; then
    echo "removing pre-existing source directory $INSTALL_LOCATION/src"
    rm -rf src
fi

# llvm source
wget http://releases.llvm.org/$LLVM_VERSION/llvm-$LLVM_VERSION.src.tar.xz
tar -xvf llvm-$LLVM_VERSION.src.tar.xz
mv llvm-$LLVM_VERSION.src src
cd src

# clang compiler source
cd tools
wget http://releases.llvm.org/$LLVM_VERSION/cfe-$LLVM_VERSION.src.tar.xz
tar -xvf cfe-$LLVM_VERSION.src.tar.xz
mv cfe-$LLVM_VERSION.src clang
cd clang

# clang extra tools (e.g. clang-tidy)
cd tools
wget http://releases.llvm.org/$LLVM_VERSION/clang-tools-extra-$LLVM_VERSION.src.tar.xz
tar -xvf clang-tools-extra-$LLVM_VERSION.src.tar.xz
mv clang-tools-extra-$LLVM_VERSION.src extra

# build everything together with cmake
cd $INSTALL_LOCATION/src
mkdir build
cd build
if [ -f "CMakeCache.txt" ]; then
    echo "removing cmake cache to ensure clean build"
    rm CMakeCache.txt
fi
cmake ..
make -j $CPU

# create binary directory
cd $INSTALL_LOCATION/src
ln -sf build/bin bin
ln -s $SYSTEM_HEADER_LOCATION/* build/lib/clang/$LLVM_VERSION/include/
