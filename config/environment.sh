#!/bin/bash

# data grip formatter with command line
function dgformat() {
    if [ "$1" == "" ]; then echo "no file target passed to formatter" && return; fi
    TARGET="$(abspath $1)"
    BINARY=$APPDIR/DataGrip.app/Contents/MacOS/datagrip
    STYLES=$APPDIR/DataGrip.app/Contents/Resources/Custom.xml
    $BINARY format -s $STYLES $TARGET
}

# aliases/shortcuts
function abspath() { echo "$(
    cd "$(dirname "$1")"
    pwd -P
)/$(basename "$1")"; }
function path() { echo $PATH | sed -e $'s/:/\\\n/g'; }
function json() { python -m json.tool $1 | vim -R -c ":set ft=json" -; }
function ipy() {
    if [ -d "venv" ]; then
        venv/bin/ipython
    else
        $APPDIR/Frameworks/Python.framework/Versions/3.9/bin/ipython
    fi
}
function ipi() {
    if [ -d "venv" ]; then
        venv/bin/pip $@
    else
        $APPDIR/Frameworks/Python.framework/Versions/3.9/bin/pip $@
    fi
}
function py() {
    if [ -d "venv" ]; then
        venv/bin/python $@
    else
        $APPDIR/Frameworks/Python.framework/Versions/3.9/bin/python3 $@
    fi
}
alias ggi="git grep -nIi"
alias gg="git grep -nI"
alias pp="echo 'setting python path to $(pwd)' && export PYTHONPATH=$(pwd) && export PYLINTHOME=$(pwd)/.pylint.d"

# miscellaneous environment variables
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=~/Library/Fonts"
export APPDIR=$HOME/Applications
#export BREWDIR=$APPDIR/Brew/src # if built in home directory
export BREWDIR=/usr/local       # if installed conventionally
export GOROOT=$BREWDIR/opt/go/libexec
export GOPATH=$APPDIR/Go
export EDITOR=vim
if [ "$(command -v nvim)" ]; then alias vim="nvim"; fi
alias cxx=/usr/local/opt/llvm/bin/clang++
alias cc=/usr/local/opt/llvm/bin/clang

# path prepends
export PATH=$APPDIR/Vim/src/bin:$PATH
export PATH=$BREWDIR/bin:$PATH
export PATH=$APPDIR/NeoVim/build/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/3.6/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/3.9/bin:$PATH
# path appends
export PATH=/usr/local/opt/llvm/bin:$PATH
export PATH=$PATH:$BREWDIR/sbin

# shell behavior
stty -ixon # disable terminal flow control to allow more vim keybindings

# convenience shortcuts
alias jln="$APPDIR/Julia/src/usr/bin/julia"
alias jl="julia --optimize=3 --cpu-target native --banner=no --color=yes"
alias py36="$APPDIR/Frameworks/Python.framework/Versions/3.6/bin/python3"
alias pip36="$APPDIR/Frameworks/Python.framework/Versions/3.6/bin/pip3"
alias py37="$APPDIR/Frameworks/Python.framework/Versions/3.7/bin/python3"
alias pip37="$APPDIR/Frameworks/Python.framework/Versions/3.7/bin/pip3"
alias py38="$APPDIR/Frameworks/Python.framework/Versions/3.8/bin/python3"
alias pip38="$APPDIR/Frameworks/Python.framework/Versions/3.8/bin/pip3"
alias l="ls -Alh"

# shell convention/portability management
if [ -n "$ZSH_VERSION" ]; then    # assume using zsh shell
    unsetopt no_match             # treat wildcards (*) same way as bash
    setopt nosharehistory         # dont share live history across tmux panes
    export KEYTIMEOUT=1           # more responsive key sequences
elif [ -n "$BASH_VERSION" ]; then # assume using bash shell
    PROMPT_COLOR_DEFAULT="\[\e[m\]"
    PROMPT_COLOR_ENVIRONMENT="\[\e[0;35m\]"
    PROMPT_HOST="$PROMPT_COLOR_ENVIRONMENT\h$PROMPT_COLOR_DEFAULT"
    PROMPT_TIME="$PROMPT_COLOR_ENVIRONMENT\t$PROMPT_COLOR_DEFAULT"
    PROMPT_FOLDER="$PROMPT_COLOR_ENVIRONMENT\w$PROMPT_COLOR_DEFAULT"
    PROMPT_BRANCH="$PROMPT_COLOR_ENVIRONMENT\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$PROMPT_COLOR_DEFAULT"
    PROMPT="$PROMPT_COLOR_ENVIRONMENT\n\\$ $PROMPT_COLOR_DEFAULT"
    export PS1="[$PROMPT_HOST][$PROMPT_TIME][$PROMPT_FOLDER][$PROMPT_BRANCH]$PROMPT"
fi

function VENV(){
    if [ -d venv ]; then
        echo "entering virtual environment: $(pwd)/venv"
        source venv/bin/activate
    elif [ -d ~/venv ]; then
        echo "entering virtual environment: $(pwd)/venv"
        source venv/bin/activate
    else
        echo "no virtual environment found in current or home directory"
    fi
}

function UTIL(){
    if [ -f chest/utilities.sh ]; then
        source chest/utilities.sh
    elif [ -f util/utils.sh ]; then
        source util/utils.sh
    else
        echo "no utilities file found"
    fi
}
