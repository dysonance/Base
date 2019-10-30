ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%} %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='%{$fg[magenta]%}%~%{$reset_color%}$(git_prompt_info) %{$fg[cyan]%}%*%{$reset_color%}
$ '

