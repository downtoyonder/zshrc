function apt-import-key () {
    gpg --keyserver subkeys.pgp.net --recv-keys $1 | gpg --armor --export $1 | sudo apt-key add -
}

# translate via google language tools (more lightweight than leo)
# http://www.commandlinefu.com/commands/view/5034/
# translate() {
#     wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'
# }

# delete-to-previous-slash
# http://www.zsh.org/mla/users/2005/msg01314.html
backward-delete-to-slash () {
  local WORDCHARS=${WORDCHARS//\//}
  zle .backward-delete-word
}
zle -N backward-delete-to-slash
# bind to control Y
bindkey "^Y" backward-delete-to-slash