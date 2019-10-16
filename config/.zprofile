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

# shell prompt formatting style
DEFAULT_COLOR="%[%e[m%]"
TIME_COLOR="%[%e[0;36m%]"
TIME="$TIME_COLOR%t$DEFAULT_COLOR"
FOLDER_COLOR="%[%e[0;35m%]"
FOLDER="$FOLDER_COLOR%w$DEFAULT_COLOR"
BRANCH_COLOR="%[%e[1;32m%]"
BRANCH="$BRANCH_COLOR%$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$DEFAULT_COLOR"
PROMPT_COLOR="%[%e[0;33m%]"
PROMPT="$PROMPT_COLOR%n%%$ $DEFAULT_COLOR"
PS1="%n[$TIME][$FOLDER][$BRANCH]%n$PROMPT_COLOR%%$ $DEFAULT_COLOR"
export PS1

# miscellaneous environment variables
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=~/Library/Fonts"
export APPDIR=$HOME/Chest/apps
export GOROOT=$APPDIR/brew/src/opt/go/libexec
export EDITOR=vim

# path additions
export PATH=$APPDIR/vim/src/bin:$PATH
export PATH=$APPDIR/brew/src/bin:$PATH
export PATH=$APPDIR/frameworks/Python.framework/Versions/Current/bin:$PATH
export PATH=$PATH:$APPDIR/llvm/src/bin
export PATH=$HOME/Applications/Julia/Julia-1.2.app/Contents/Resources/julia/bin:$PATH
export PATH=$PATH:$APPDIR/brew/src/sbin
# disable flow control in the terminal completely
# (allows more keybindings for things like vim)
# (see here: https://vim.fandom.com/wiki/Map_Ctrl-S_to_save_current_or_new_files)
stty -ixon

# convenience shortcuts
alias edit="vim"
alias jln="$APPDIR/julia/src/usr/bin/julia"
alias jl="julia -O3 -q"
alias py36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/python3"
alias pip36="$APPDIR/frameworks/Python.framework/Versions/3.6/bin/pip3"
alias py37="$APPDIR/frameworks/Python.framework/Versions/3.7/bin/python3"
alias pip37="$APPDIR/frameworks/Python.framework/Versions/3.7/bin/pip3"
alias py="py37"
alias ipi="pip37"
alias ipy="$APPDIR/frameworks/Python.framework/Versions/3.7/bin/ipython"
alias l="ls -Alh"


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
