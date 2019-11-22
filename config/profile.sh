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

# path prepends
export PATH=$APPDIR/Vim/src/bin:$PATH
export PATH=$APPDIR/Brew/src/bin:$PATH
export PATH=$APPDIR/NeoVim/src/build/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/3.8/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/3.6/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/Current/bin:$PATH
export PATH=$APPDIR/Julia/Julia-1.2.app/Contents/Resources/julia/bin:$PATH
# path appends
export PATH=$PATH:$APPDIR/LLVM/src/bin
export PATH=$PATH:$APPDIR/Brew/src/sbin

# shell behavior
stty -ixon  # disable terminal flow control to allow more vim keybindings

# convenience shortcuts
alias jln="$APPDIR/Julia/src/usr/bin/julia"
alias jl="julia --banner=no --optimize=3 -g"
alias py36="$APPDIR/Frameworks/Python.framework/Versions/3.6/bin/python3"
alias pip36="$APPDIR/Frameworks/Python.framework/Versions/3.6/bin/pip3"
alias py38="$APPDIR/Frameworks/Python.framework/Versions/3.8/bin/python3"
alias pip38="$APPDIR/Frameworks/Python.framework/Versions/3.8/bin/pip3"
alias py="py38"
alias ipi="pip38"
alias ipy="$APPDIR/Frameworks/Python.framework/Versions/3.8/bin/ipython"
alias l="ls -Alh"

if [ -n "$ZSH_VERSION" ]; then  # assume using zsh shell
    unsetopt no_match  # treat wildcards (*) same way as bash
    setopt nosharehistory  # dont share live history across tmux panes
elif [ -n "$BASH_VERSION" ]; then  # assume using bash shell
    PROMPT_COLOR_DEFAULT="\[\e[m\]"
    PROMPT_COLOR_ENVIRONMENT="\[\e[0;35m\]"
    PROMPT_HOST="$PROMPT_COLOR_ENVIRONMENT\h$PROMPT_COLOR_DEFAULT"
    PROMPT_TIME="$PROMPT_COLOR_ENVIRONMENT\t$PROMPT_COLOR_DEFAULT"
    PROMPT_FOLDER="$PROMPT_COLOR_ENVIRONMENT\w$PROMPT_COLOR_DEFAULT"
    PROMPT_BRANCH="$PROMPT_COLOR_ENVIRONMENT\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$PROMPT_COLOR_DEFAULT"
    PROMPT="$PROMPT_COLOR_ENVIRONMENT\n\\$ $PROMPT_COLOR_DEFAULT"
    export PS1="[$PROMPT_HOST][$PROMPT_TIME][$PROMPT_FOLDER][$PROMPT_BRANCH]$PROMPT"
fi
