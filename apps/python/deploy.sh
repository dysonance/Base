#!/bin/bash

# exit if an error occurs
set -e

# define variables/settings to build as desired
PYTHON_VERSION=$1
APP_DIRECTORY=$HOME/Applications

# install dependencies
BREW_DEPENDENCIES=(openssl sqlite zlib tcl-tk qt)
BREW_INSTALLED=$(brew list)
for dep in $BREW_DEPENDENCIES; do
    if [ "$(echo $BREW_INSTALLED | grep $dep)" == "" ]; then
        brew install $dep
    fi
    brew_prefix=$(brew --prefix $dep)
    export PATH=$PATH:$brew_prefix/bin
    export LDFLAGS="$LDFLAGS -L$brew_prefix/lib"
    export CFLAGS="$CFLAGS -I$brew_prefix/include"
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$brew_prefix/lib/pkgconfig
done

# checkout source code and setup directories
cd $APP_DIRECTORY
if ! [ -d "Python" ]; then mkdir Python; fi
cd Python
if ! [ -d "src" ]; then git clone https://github.com/python/cpython src; fi
cd src
git checkout master --quiet
git pull --quiet
if [ "$PYTHON_VERSION" == "" ]; then PYTHON_VERSION=$(git tag | grep -v rc | grep -v "[ab][0-9]" | tail -n1 | sed 's/v//g'); fi
INSTALL_DIRECTORY="$APP_DIRECTORY/Python/Versions/$PYTHON_VERSION"
if ! [ -d "$INSTALL_DIRECTORY" ]; then mkdir -p $INSTALL_DIRECTORY; fi

# configure the installation
FRAMEWORK_DIRECTORY=$APP_DIRECTORY/Frameworks
if ! [ -d "$FRAMEWORK_DIRECTORY" ]; then mkdir $FRAMEWORK_DIRECTORY; fi
export PYTHON_HOME=$INSTALL_DIRECTORY
export CC=clang

# run build
echo "building python version $PYTHON_VERSION"
git checkout v$PYTHON_VERSION --quiet
git clean -xfd
./configure \
    --prefix=$INSTALL_DIRECTORY \
    --datadir=$INSTALL_DIRECTORY/share \
    --datarootdir=$INSTALL_DIRECTORY/share \
    --enable-framework=$FRAMEWORK_DIRECTORY \
    --enable-ipv6 \
    --enable-loadable-sqlite-extensions \
    --enable-optimizations \
    --with-dtrace \
    --with-lto \
    --with-openssl=$SSL_PATH \
    --with-tcltk-includes="$CFLAGS" \
    --with-tcltk-libs="$LDFLAGS -ltcl$TK_VERSION -ltk$TK_VERSION" \
    --without-ensurepip \
    --without-gcc
make -j $CPU
make frameworkinstallextras PYTHONAPPSDIR=$INSTALL_DIRECTORY/share/python
make install PYTHONAPPSDIR=$INSTALL_DIRECTORY

# create symbolic links to simplify version management
cd $INSTALL_DIRECTORY/..
if [ -d "Current" ]; then rm Current; fi
ln -sf $PYTHON_VERSION Current

# install pip
cd $INSTALL_DIRECTORY/../..
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./Versions/Current/bin/python3 get-pip.py

# install python packages
cd $HOME/Base
PYTHON_PACKAGES=$(tail -n $(expr $(wc -l data/python_packages.csv | sed "s/[A-z \/\.]//g") - 1) data/python_packages.csv | sed s/,.*$//g)
cd apps/frameworks/Python.framework/Versions/Current/bin
./pip3 install $PYTHON_PACKAGES
