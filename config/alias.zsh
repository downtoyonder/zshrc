# But still use emacs-style zsh bindings
# http://superuser.com/questions/403355/how-do-i-get-searching-through-my-command-history-working-with-tmux-and-zshell
bindkey -e

# Replacement
alias ..="cd ..;ls"
alias ...="cd ../..;ls"
alias ....="cd ../../..;ls"
alias .....="cd ../../../..;ls"
alias ......="cd ../../../../..;ls"

# Unix
alias ls="ls --color"
alias grep='grep --color=auto'
alias ips="ip -brief address"

# Application
alias d="docker"
alias dc="docker compose"

alias vi="vim"
alias vim="vim"
