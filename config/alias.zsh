export EDITOR="vim"
# But still use emacs-style zsh bindings
# http://superuser.com/questions/403355/how-do-i-get-searching-through-my-command-history-working-with-tmux-and-zshell
bindkey -e

alias ls="ls --color"

alias d="docker"
alias dc="docker-compose"

alias vi="vim"
alias vim="vim"

alias viedit=" $EDITOR $HOME/.vim/vimrc"

alias grep='grep --color=auto'