#/bin/bash

cd $HOME/Chest/apps/musescore

INSTALL_DIRECTORY=$HOME/Chest/apps/musescore/bin
MUSESCORE_REPOSITORY="https://github.com/musescore/MuseScore"

if ! [ -d "src" ]; then
    git clone $MUSESCORE_REPOSITORY src
fi

cd src
git fetch

if [ "$1" == "" ]; then
    MUSESCORE_VERSION=$(git tag | tail -n1)
else
    MUSESCORE_VERSION=$1
fi

git checkout $MUSESCORE_VERSION

if ! [ -d "$INSTALL_DIRECTORY" ]; then
    mkdir $INSTALL_DIRECTORY
fi

if [[ -z "${CPU}" ]]; then
    CPU=4
fi

brew install libvorbis libogg libsndfile pkg-config portaudio jack lame cmake git

export CXX=clang++
export C=clang
export CMAKE_CXX_COMPILER=$(which clang++)
export CMAKE_C_COMPILER=$(which clang)

QT_PATH=$(brew --prefix qt)
export LDFLAGS="-L$QT_PATH/lib"
export CPPFLAGS="-I$QT_PATH/include"
export PKG_CONFIG_PATH="$QT_PATH/lib/pkgconfig"
export PATH="$QT_PATH/bin:$PATH"

# FIXME: this build doesnt work at all
git checkout .
git clean -xfd
make -f Makefile.osx revision CMAKE_CXX_COMPILER=$CMAKE_CXX_COMPILER CMAKE_C_COMPILER=$CMAKE_C_COMPILER
make -f Makefile.osx release CMAKE_CXX_COMPILER=$CMAKE_CXX_COMPILER CMAKE_C_COMPILER=$CMAKE_C_COMPILER
