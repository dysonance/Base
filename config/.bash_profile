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

# path additions
export PATH=$PATH:$HOME/Chest/apps/llvm/llvm/bin
export PATH=$HOME/Chest/apps/vim/src/bin:$PATH
export PATH=$PATH:$HOME/Chest/apps/frameworks/Python.framework/Versions/Current/bin
export PATH=$PATH:$HOME/Applications/Julia-1.1.app/Contents/Resources/julia/bin

# convenience shortcuts
alias jln="$HOME/Chest/apps/julia/nightly/usr/bin/julia"
alias jl="julia --optimize=3 -q -g"
alias py="$HOME/Chest/apps/frameworks/Python.framework/Versions/Current/bin/python3"
alias ipi="$HOME/Chest/apps/frameworks/Python.framework/Versions/Current/bin/pip3"
alias ipy="$HOME/Chest/apps/frameworks/Python.framework/Versions/Current/bin/ipython"
alias edit="vim"

function list()
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

if [ -d "$HOME/Applications/Google Chrome.app" ]; then
    export BROWSER=$HOME/Applications/Google\ Chrome.app
elif [ -d "/Applications/Google Chrome.app" ]; then
    export BROWSER=/Applications/Google\ Chrome.app
fi
