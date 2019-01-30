# used by tmux
export TERM="xterm-256color"

# terminal interface customization
export CLICOLOR=1                      # enable terminal colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # directory listing colors

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

# julia convenience shortcuts
JULIA_VERSION=1.1
alias jln="$HOME/Preferences/apps/julia/nightly/usr/bin/julia"
alias jl="julia -q -O3 -g2"

# path additions
export PATH=$PATH:$HOME/Preferences/apps/llvm/llvm/bin
export PATH=$HOME/Preferences/apps/vim/vim/bin:$PATH
export PATH=$HOME/Preferences/apps/python/versions/current/bin:$PATH
export PATH=$PATH:$HOME/Applications/Julia-$JULIA_VERSION.app/Contents/Resources/julia/bin

function Ls()
{
    ls -AlnT $@
}

function BashColors()
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

alias edit="vim"
