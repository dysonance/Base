# terminal interface customization
export CLICOLOR=1  # enable terminal colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx  # directory listing colors
export PS1="[\[\e[36m\]\u\[\e[m\]][\[\e[36m\]\t\[\e[m\]][\[\e[36m\]\W\[\e[m\]]\n\[\e[33m\]\\$\[\e[m\] "

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

