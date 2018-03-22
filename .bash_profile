# terminal interface customization
export CLICOLOR=1  # enable terminal colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx  # directory listing colors
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

# julia convenience methods
export PATH="$HOME/Applications/Julia/0.6/usr/bin/:$PATH"  # Julia 0.6
alias julia-0.5="$HOME/Applications/Julia/0.5/usr/bin/julia"
alias julia-0.6="$HOME/Applications/Julia/0.6/usr/bin/julia"
alias julia-master="$HOME/Applications/Julia/master/usr/bin/julia"

export PATH="$HOME/Applications/CMake/cmake-3.7.1/bin/:$PATH"  # CMake
export PATH=$PATH:$HOME/bin

# application-specific
export R_LIBS_USER=$HOME/R_LIBS  # non-root R language package installation directory
export VIMRUNTIME=~/Applications/vim/runtime  # change vim runtime path (rtp) after upgrading newer vim version
export TERM="xterm-256color"

