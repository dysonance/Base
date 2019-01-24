#!/bin/bash

# Note: See this anser on StackOverflow for a good explanation of how this needs to be structured
# https://stackoverflow.com/a/49702159/2271756

INSTALL_LOCATION=$HOME/Preferences/apps/llvm
LLVM_VERSION=7.0.1

cd $INSTALL_LOCATION

# llvm source
wget http://releases.llvm.org/$LLVM_VERSION/llvm-$LLVM_VERSION.src.tar.xz
tar -xvf llvm-$LLVM_VERSION.src.tar.xz
mv llvm-$LLVM_VERSION.src llvm
cd llvm

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
cd $INSTALL_LOCATION/llvm
mkdir build
cd build
cmake ..
cmake --build .
make -j $CPU

# create binary directory
cd $INSTALL_LOCATION/llvm
mkdir bin
ln -sf build/bin/* bin/
