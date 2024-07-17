# set vim key bind
bindkey -v

# 命令建议插件
# zplug "zsh-users/zsh-autosuggestions"
# 绑定 alt + a
bindkey '^[a' autosuggest-accept

# arrow up/down searches in history if line is already started
# 上下键根据已输入的命令匹配历史
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
# zle -N widget-name [widget-function], create a user-defined widget
# If no function name is specified, it defaults to the same name as the widget
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# Terminfo and Terrmcap: https://tldp.org/HOWTO/Text-Terminal-HOWTO-16.html
# Terminfo (formerly Termcap) is a database of terminal capabilities and more
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
