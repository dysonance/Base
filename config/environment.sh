#!/bin/bash

# utility functions/aliases
function path() { echo $PATH | sed -e $'s/:/\\\n/g'; }
function json() { python -m json.tool $1 | vim -R -c ":set ft=json" -; }
function ipy() { if [ -d "venv" ]; then venv/bin/ipython; else ipython; fi; }
function ipi() { if [ -d "venv" ]; then venv/bin/pip $@; else pip3 $@; fi; }
function py() { if [ -d "venv" ]; then PYTHONPATH=$(pwd) venv/bin/python $@; else PYTHONPATH=$(pwd) python3 $@; fi; }
function gls() { git ls-files ${@:2} | grep $1; }
alias ggi="git grep -nIi"
alias gg="git grep -nI"
alias pp="echo 'setting python path to $(pwd)' && export PYTHONPATH=$(pwd) && export PYLINTHOME=$(pwd)/.pylint.d"

function genstubs() {
    if [ -d "venv" ]; then source venv/bin/activate; fi
    local pkgs=$(git ls-files | grep __init__\\.py$ | sed "s/\/.*//g" | uniq)
    for pkg in $pkgs; do
        if [ "$pkg" = "." ]; then continue; fi
        echo "generating python type stubs for $pkg"
        stubgen -o .typings -p $pkg
    done
    if [ -d "venv" ]; then deactivate; fi
}

# miscellaneous environment variables
export HISTFILE="$HOME/.history/zsh/$USER"
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=~/Library/Fonts"
export APPDIR=$HOME/Applications
export R_LIBS_USER=$HOME/Library/R
export BREWDIR=/usr/local # if installed conventionally
export EDITOR=vim
alias vi="$APPDIR/Vim/bin/vim"
if [ "$(command -v nvim)" ]; then alias vim="nvim"; fi

# path prepends
export PATH=$APPDIR/Vim/bin:$PATH
export PATH=$APPDIR/NeoVim/build/bin:$PATH
export PATH=$HOME/.pyenv/versions/3.8.7/bin:$PATH
export PATH=$HOME/.pyenv/versions/2.7.18/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/3.8/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=/usr/local/opt/llvm/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
# path appends
export PATH=$PATH:$APPDIR/Go/bin
# contextual paths
export PYTHONPATH=$(pwd)

# shell behavior
stty -ixon # disable terminal flow control to allow more vim keybindings

# convenience shortcuts
alias jln="$APPDIR/Julia/src/usr/bin/julia"
alias py36="$APPDIR/Python/Versions/3.6.5/bin/python3"
alias jl="julia --optimize=3 --cpu-target native --banner=no --color=yes"
alias ijl="jupyter console --kernel=julia-1.5 --no-confirm-exit --ZMQTerminalInteractiveShell.editing_mode=vi"
alias l="ls -Alh"

# fuzzy history search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

function VENV() {
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

function UTIL() {
    if [ -f chest/utilities.sh ]; then
        source chest/utilities.sh
    elif [ -f util/utils.sh ]; then
        source util/utils.sh
    else
        echo "no utilities file found"
    fi
}

function ColorTest() {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}
