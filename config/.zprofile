#!/bin/zsh

# utility functions
function bash_colors()
{
    local _index_=$1
    if [ "$_index_" == "" ]; then
        for i in {0..255}; do
            printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
        done
    else
        printf "\x1b[38;5;${_index_}mcolour${_index_}\x1b[0m\n"
    fi
}

function print_path()
{
    echo $PATH | sed -e $'s/:/\\\n/g'
}

function search_path()
{
    local _filter=$1
    if [ "$_filter" == "" ]; then
        print_path
    else
        print_path | grep $_filter
    fi
}

# miscellaneous environment variables
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=~/Library/Fonts"
export APPDIR=$HOME/Base/apps
export GOROOT=$APPDIR/brew/src/opt/go/libexec
export EDITOR=vim

# path additions
export PATH=$APPDIR/vim/src/bin:$PATH
export PATH=$APPDIR/brew/src/bin:$PATH
export PATH=$APPDIR/frameworks/Python.framework/Versions/Current/bin:$PATH
export PATH=$PATH:$APPDIR/llvm/src/bin
export PATH=$HOME/Applications/Julia/Julia-1.2.app/Contents/Resources/julia/bin:$PATH
export PATH=$PATH:$APPDIR/brew/src/sbin

# shell behavior
stty -ixon  # disable terminal flow control to allow more vim keybindings
unsetopt no_match  # treat wildcards (*) same way as bash

# convenience shortcuts
alias edit="vim"
alias jln="$APPDIR/julia/src/usr/bin/julia"
alias jl="julia -O3 -q"
alias py36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/python3"
alias pip36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/pip3"
alias py38="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/python3"
alias pip38="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/pip3"
alias py="py38"
alias ipi="pip38"
alias ipy="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/ipython"
alias l="ls -Alh"
