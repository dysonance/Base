#!/bin/bash

# NOTE: See this anser on StackOverflow for a good explanation of how to structure builds using tar files
# https://stackoverflow.com/a/49702159/2271756
# NOTE: See this blog post for an intuitive and straightforward setup
# https://shaharmike.com/cpp/build-clang/

GIT_URL="https://github.com/llvm-mirror"
VERSION_BRANCH=release_90

# dependency handling
DEPENDENCIES=(git cmake make libffi swig)
for dep in "${DEPENDENCIES[@]}"; do echo "installing dependency: $dep" && brew install $dep; done

# define variables required for build downstream
FFI_DIR=$(brew --prefix libffi)
FFI_VERSION=$(brew list --versions libffi | sed "s/libffi //g")
FFI_LIBS=$FFI_DIR/lib
FFI_INCLUDES=$FFI_DIR/lib/libffi-$FFI_VERSION/include

# directory setup
cd $APPDIR
if ! [ -d "LLVM" ]; then mkdir LLVM; fi
if ! [ -d "LLVM/build" ]; then mkdir LLVM/build; fi

# clone the source from llvm github mirrors
cd LLVM
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/llvm llvm
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/clang llvm/tools/clang
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/clang-tools-extra llvm/tools/clang/tools/extra
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/compiler-rt llvm/projects/compiler-rt
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/libcxx llvm/projects/libcxx
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/libcxxabi llvm/projects/libcxxabi
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/libunwind llvm/tools/libunwind
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/lld llvm/tools/lld
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/lldb llvm/tools/lldb
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/openmp llvm/projects/openmp
git clone --depth 1 --single-branch --branch $VERSION_BRANCH $GIT_URL/polly llvm/tools/polly

# build
cd build

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DFFI_INCLUDE_DIR=$FFI_INCLUDES \
    -DFFI_LIBRARY_DIR=$FFI_LIBS \
    -DLIBOMP_ARCH=x86_64 \
    -DLIBOMP_INSTALL_ALIASES=OFF \
    -DLINK_POLLY_INTO_TOOLS=ON \
    -DLLDB_DISABLE_PYTHON=1 \
    -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
    -DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON \
    -DLLVM_BUILD_LLVM_DYLIB=ON \
    -DLLVM_CREATE_XCODE_TOOLCHAIN=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_ENABLE_FFI=ON \
    -DLLVM_ENABLE_LIBCXX=ON \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_INCLUDE_DOCS=OFF \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_OPTIMIZED_TABLEGEN=ON \
    -DLLVM_TARGETS_TO_BUILD=all \
    -DWITH_POLLY=ON \
    ../llvm

make -j $CPU
make install
make install-xcode-toolchain
