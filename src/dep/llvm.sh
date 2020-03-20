#!/bin/bash

# NOTE: See this anser on StackOverflow for a good explanation of how to structure builds using tar files
# https://stackoverflow.com/a/49702159/2271756
# NOTE: See this blog post for an intuitive and straightforward setup
# https://shaharmike.com/cpp/build-clang/

GIT_URL="https://github.com/llvm-mirror"
VERSION_BRANCH=release_90

# dependency handling
DEPENDENCIES=(git cmake make)
for dep in "${DEPENDENCIES[@]}"; do echo "installing dependency: $dep" && brew install $dep; done

# directory setup
cd $APPDIR
if ! [ -d "LLVM" ]; then mkdir LLVM; fi
cd LLVM
git clone --single-branch --branch $VERSION_BRANCH $GIT_URL/llvm llvm
git clone --single-branch --branch $VERSION_BRANCH $GIT_URL/clang llvm/tools/clang
git clone --single-branch --branch $VERSION_BRANCH $GIT_URL/clang-tools-extra llvm/tools/clang/tools/extra
git clone --single-branch --branch $VERSION_BRANCH $GIT_URL/compiler-rt llvm/projects/compiler-rt
git clone --single-branch --branch $VERSION_BRANCH $GIT_URL/libcxx llvm/projects/libcxx
git clone --single-branch --branch $VERSION_BRANCH $GIT_URL/libcxxabi llvm/projects/libcxxabi
git clone --single-branch --branch $VERSION_BRANCH $GIT_URL/lld llvm/tools/lld
# build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../llvm
make -j $CPU
