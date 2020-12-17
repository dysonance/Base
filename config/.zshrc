# path to oh-my-zsh installation.
export ZSH="$HOME/Applications/Shell/.oh-my-zsh"

# name of the theme to load (see https://github.com/robbyrussell/oh-my-zsh/wiki/Themes)
ZSH_THEME="dysonance"

# zsh plugins to load (note too many plugins slow down shell startup)
plugins=(vi-mode tmux tmuxinator)

source $ZSH/oh-my-zsh.sh

# change cursor based on vi mode
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)
zle-keymap-select () {
    if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[2 q"
        else
            # the insert mode for vi
            echo -ne "\e[5 q"
        fi
    fi
}

# disable automatic directory navigation
unsetopt autocd
