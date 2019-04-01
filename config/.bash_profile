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

# miscellaneous environment variables
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=~/Library/Fonts"
export APPDIR=$HOME/Chest/apps
export GOROOT=$APPDIR/brew/src/opt/go/libexec

# path additions
export PATH=$APPDIR/vim/src/bin:$PATH
export PATH=$APPDIR/brew/src/bin:$PATH
export PATH=$APPDIR/frameworks/Python.framework/Versions/Current/bin:$PATH
export PATH=$PATH:$APPDIR/llvm/src/bin
export PATH=$PATH:$HOME/Applications/Julia/Julia-1.1.app/Contents/Resources/julia/bin

# convenience shortcuts
alias edit="vim"
alias jln="$HOME/Chest/apps/julia/src/usr/bin/julia"
alias jl="julia -O3 -q"
alias py36="$HOME/Chest/apps/frameworks/Python.framework/Versions/3.6/bin/python3"
alias pip36="$HOME/Chest/apps/frameworks/Python.framework/Versions/3.6/bin/pip3"
alias py37="$HOME/Chest/apps/frameworks/Python.framework/Versions/3.7/bin/python3"
alias pip37="$HOME/Chest/apps/frameworks/Python.framework/Versions/3.7/bin/pip3"
alias py="py37"
alias ipi="pip37"
alias ipy="$HOME/Chest/apps/frameworks/Python.framework/Versions/Current/bin/ipython"

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
