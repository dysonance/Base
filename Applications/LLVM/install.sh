#!/bin/bash

wget http://releases.llvm.org/6.0.0/llvm-6.0.0.src.tar.xz
tar xf llvm-6.0.0.src.tar.xz
cd llvm-6.0.0.src

wget http://releases.llvm.org/6.0.0/cfe-6.0.0.src.tar.xz
tar xf cfe-6.0.0.src.tar.xz
mv llvm-6.0.0.src/cfe-6.0.0.src llvm-6.0.0.src/tools/clang

wget http://releases.llvm.org/6.0.0/clang-tools-extra-6.0.0.src.tar.xz
tar xf clang-tools-extra-6.0.0.src.tar.xz
mv clang-tools-extra-6.0.0.src llvm-6.0.0.src/tools/clang/tools/extra

mkdir llvm
cd llvm

cmake ../llvm-6.0.0.src
make -j $CPU install
