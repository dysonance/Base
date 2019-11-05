# utility functions
function shellcolors()
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

function showpath()
{
    echo $PATH | sed -e $'s/:/\\\n/g'
}

function searchpath()
{
    local _filter=$1
    if [ "$_filter" == "" ]; then
        showpath
    else
        showpath | grep $_filter
    fi
}

# miscellaneous environment variables
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=~/Library/Fonts"
export APPDIR=$HOME/Applications
export GOROOT=$APPDIR/Brew/src/opt/go/libexec
export EDITOR=vim

# path additions
export PATH=$APPDIR/Vim/src/bin:$PATH
export PATH=$APPDIR/Brew/src/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/Current/bin:$PATH
export PATH=$PATH:$APPDIR/LLVM/src/bin
export PATH=$APPDIR/Julia/Julia-1.2.app/Contents/Resources/julia/bin:$PATH
export PATH=$PATH:$APPDIR/Brew/src/sbin

# shell behavior
stty -ixon  # disable terminal flow control to allow more vim keybindings

# convenience shortcuts
alias jln="$APPDIR/julia/src/usr/bin/julia"
alias jl="julia --banner=no --optimize=3 -g"
alias py36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/python3"
alias pip36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/pip3"
alias py38="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/python3"
alias pip38="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/pip3"
alias py="py38"
alias ipi="pip38"
alias ipy="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/ipython"
alias l="ls -Alh"

if [ -n "$ZSH_VERSION" ]; then
    # assume using zsh shell
    unsetopt no_match  # treat wildcards (*) same way as bash
elif [ -n "$BASH_VERSION" ]; then  # assume using bash shell
    # shell prompt formatting colors
    BASH_WHITE="\[\e[m\]"
    BASH_CYAN_DARK="\[\e[0;36m\]"
    BASH_MAGENTA_DARK="\[\e[0;35m\]"
    BASH_GREEN_BOLD="\[\e[1;32m\]"
    BASH_YELLOW_DARK="\[\e[0;33m\]"
    DEFAULT_COLOR="$BASH_WHITE"
    # bash prompt customization
    ENVIRONMENT_COLOR="$BASH_MAGENTA_DARK"
    HOST="$ENVIRONMENT_COLOR\h$DEFAULT_COLOR"
    TIME="$ENVIRONMENT_COLOR\t$DEFAULT_COLOR"
    FOLDER="$ENVIRONMENT_COLOR\w$DEFAULT_COLOR"
    BRANCH="$ENVIRONMENT_COLOR\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$DEFAULT_COLOR"
    PROMPT="$ENVIRONMENT_COLOR\n\\$ $DEFAULT_COLOR"
    export PS1="[$HOST][$TIME][$FOLDER][$BRANCH]$PROMPT"
fi
