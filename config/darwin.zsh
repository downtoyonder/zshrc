# 命令建议插件
# zplug "zsh-users/zsh-autosuggestions"
# 绑定 option + a
bindkey 'å' autosuggest-accept

# arrow up/down searches in history if line is already started
# 上下键根据已输入的命令匹配历史
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


export PATH=/opt/homebrew/bin:"$PATH"
