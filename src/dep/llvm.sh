#!/bin/bash

# Note: See this anser on StackOverflow for a good explanation of how this needs to be structured
# https://stackoverflow.com/a/49702159/2271756

SYSTEM_HEADER_LOCATION=/usr/include/c++/4.2.1
LLVM_VERSION=9.0.0

# dependency handling
DEPENDENCIES=(wget cmake make)
for dep in "${DEPENDENCIES[@]}"; do echo "installing dependency: $dep" && brew install $dep; done

# directory setup
cd $APPDIR
if ! [ -d "LLVM" ]; then mkdir LLVM; fi
cd LLVM
if [ -d "src" ]; then
    echo "removing pre-existing source directory $APPDIR/LLVM/src"
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
cd $APPDIR/LLVM/src
mkdir build
cd build
if [ -f "CMakeCache.txt" ]; then
    echo "removing cmake cache to ensure clean build"
    rm CMakeCache.txt
fi
cmake ..
make -j $CPU

# create binary directory
cd $APPDIR/LLVM/src
ln -sf build/bin bin
ln -s $SYSTEM_HEADER_LOCATION/* build/lib/clang/$LLVM_VERSION/include/
