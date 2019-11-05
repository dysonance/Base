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

# terminal interface customization
export CLICOLOR=1                      # enable terminal colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # directory listing colors
export TERM="xterm-256color"           # used by tmux
export HISTSIZE=                       # unlimited command history
export HISTFILESIZE=                   # unlimited command history file
set -o vi                              # provide vim-like keybindings for navigating the shell
bind -m vi-insert "\C-l":clear-screen  # fix clear screen shortcut broken by vi mode
stty -ixon                             # disable shell flow control completely to allow more vim keybindings

# shell prompt formatting style
DEFAULT_COLOR="\[\e[m\]"
TIME_COLOR="\[\e[0;36m\]"
TIME="$TIME_COLOR\t$DEFAULT_COLOR"
FOLDER_COLOR="\[\e[0;35m\]"
FOLDER="$FOLDER_COLOR\w$DEFAULT_COLOR"
BRANCH_COLOR="\[\e[1;32m\]"
BRANCH="$BRANCH_COLOR\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$DEFAULT_COLOR"
PROMPT_COLOR="\[\e[0;33m\]"
PROMPT="$PROMPT_COLOR\n\\$ $DEFAULT_COLOR"
PS1="\n[$TIME][$FOLDER][$BRANCH]\n$PROMPT_COLOR\\$ $DEFAULT_COLOR"
export PS1

# miscellaneous environment variables
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=~/Library/Fonts"
export APPDIR=$HOME/Applications
export GOROOT=$APPDIR/Brew/src/opt/go/libexec
export EDITOR=vim

# path additions
export PATH=$APPDIR/Vim/src/bin:$PATH
export PATH=$APPDIR/Frameworks/Python.framework/Versions/Current/bin:$PATH
export PATH=$APPDIR/Julia/Julia-1.2.app/Contents/Resources/julia/bin:$PATH
export PATH=$APPDIR/Brew/src/bin:$PATH
export PATH=$PATH:$HOME/Applications/LLVM/src/bin
export PATH=$PATH:$HOME/Applications/Brew/src/sbin

# convenience shortcuts
alias l="ls -Alh"
alias edit="vim"

# version management shortcuts
alias jl="julia -O3 -q"
alias jln="$APPDIR/julia/src/usr/bin/julia"
alias py36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/python3"
alias ipy36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/ipython"
alias pip36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/pip3"
alias py38="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/python3"
alias ipy38="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/ipython"
alias pip38="$APPDIR/frameworks/Python.framework/Versions/3.8/bin/pip3"
alias py="py38"
alias ipy="ipy38"
alias ipi="pip38"

# # production bash prompt colors
# DEFAULT_COLOR="\[\e[m\]"
# ENVIRONMENT_COLOR="\[\e[0;91m\]"  # red for production
# ENVIRONMENT_COLOR="\[\e[0;94m\]"  # blue for development
# HOST="$ENVIRONMENT_COLOR\h$DEFAULT_COLOR"
# TIME="$ENVIRONMENT_COLOR\t$DEFAULT_COLOR"
# FOLDER="$ENVIRONMENT_COLOR\w$DEFAULT_COLOR"
# BRANCH="$ENVIRONMENT_COLOR\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$DEFAULT_COLOR"
# PROMPT="$ENVIRONMENT_COLOR\n\\$ $DEFAULT_COLOR"
# export PS1="[$HOST][$TIME][$FOLDER][$BRANCH]$PROMPT"
