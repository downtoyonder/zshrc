# 命令建议插件
# zplug "zsh-users/zsh-autosuggestions"
# 绑定 alt + a 
bindkey "^[a" autosuggest-accept

# arrow up/down searches in history if line is already started
# 上下键根据已输入的命令匹配历史
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
bindkey "$terminfo[kcud1]" history-beginning-search-forward-end


