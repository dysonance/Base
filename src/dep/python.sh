#!/bin/bash

# exit if an error occurs
set -e

# define variables/settings to build as desired
PYTHON_VERSION=$1
APPDIR=$HOME/Applications

# install dependencies
BREW_DEPENDENCIES=(openssl sqlite zlib qt freetype tcl-tk xz)
BREW_INSTALLED=$(brew list)
for dep in "${BREW_DEPENDENCIES[@]}"; do
    echo "setting up dependency: $dep"
    if [ "$(echo $BREW_INSTALLED | grep $dep)" == "" ]; then
        echo "\tinstalling $dep since not currently installed"
        brew install $dep
    fi
    brew_prefix=$(brew --prefix $dep)
    if [ -d $brew_prefix/bin ]; then export PATH=$PATH:$brew_prefix/bin; fi
    if [ -d $brew_prefix/lib ]; then export LDFLAGS="$LDFLAGS -L$brew_prefix/lib"; fi
    if [ -d $brew_prefix/include ]; then export CFLAGS="$CFLAGS -I$brew_prefix/include"; fi
    if [ -d $brew_prefix/lib/pkgconfig ]; then export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$brew_prefix/lib/pkgconfig; fi
    # dependency-specific needs
    if [ "$dep" == "openssl" ]; then export SSL_PATH=$brew_prefix; fi
    if [ "$dep" == "tcl-tk" ]; then
        TCL_TK_VERSION="$(ls $(brew --cellar tcl-tk) | cut -c1-3)"
        TCL_TK_LIBS="-L$brew_prefix/lib -ltcl$TCL_TK_VERSION -ltk$TCL_TK_VERSION"
    fi
done

# checkout source code and setup directories
cd $APPDIR
if ! [ -d "Python" ]; then mkdir Python; fi
cd Python
if ! [ -d "src" ]; then git clone https://github.com/python/cpython src; fi
cd src
git checkout master --quiet
git pull --quiet
if [ "$PYTHON_VERSION" == "" ]; then PYTHON_VERSION=$(git tag | grep -v rc | grep -v "[ab][0-9]" | tail -n1 | sed 's/v//g'); fi
INSTALL_DIRECTORY="$APPDIR/Python/Versions/$PYTHON_VERSION"
if ! [ -d "$INSTALL_DIRECTORY" ]; then mkdir -p $INSTALL_DIRECTORY; fi

# configure the installation
FRAMEWORK_DIRECTORY=$APPDIR/Frameworks
if ! [ -d "$FRAMEWORK_DIRECTORY" ]; then mkdir $FRAMEWORK_DIRECTORY; fi
export PYTHON_HOME=$INSTALL_DIRECTORY
export CPPFLAGS=$CFLAGS
export LDFLAGS=$LDFLAGS
export CC=clang
if [ "$(command -v llvm-lto)" ]; then lto_option='--with-lto'; else lto_option='--without-lto'; fi
git checkout master
git pull
git checkout v$PYTHON_VERSION --quiet
git clean -xfd
echo "configuring python build"
./configure \
    --prefix=$INSTALL_DIRECTORY \
    --datadir=$INSTALL_DIRECTORY/share \
    --datarootdir=$INSTALL_DIRECTORY/share \
    --enable-framework=$FRAMEWORK_DIRECTORY \
    --enable-ipv6 \
    --enable-loadable-sqlite-extensions \
    --enable-optimizations \
    --with-dtrace \
    --with-openssl=$SSL_PATH \
    --with-tcltk-includes="$CFLAGS" \
    --with-tcltk-libs="$TCL_TK_LIBS" \
    --without-ensurepip \
    --without-gcc \
    $lto_option

# run build
echo "building python version $PYTHON_VERSION"
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
$INSTALL_DIRECTORY/bin/python3 get-pip.py

# install python packages
cd $FRAMEWORK_DIRECTORY/Python.Framework/Versions/Current/bin
./pip3 install --force-reinstall $(cat $HOME/Base/data/packages/required/pip.txt)

# cleanup
if [ -d $APPDIR/IDLE.app ]; then rm -rf $APPDIR/IDLE.app; fi
