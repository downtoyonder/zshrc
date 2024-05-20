# ************************************************************** #
# * zplug & plugin management
# ************************************************************** #

# Using zplug as plugin manager
# Refer to https://github.com/zplug/zplug

export ZPLUG_HOME=$ZSH_HOME/zplug
source $ZPLUG_HOME/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search", as:plugin

# Supports oh-my-zsh plugins and the like
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# 命令建议插件
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# Load theme file
# zplug 'Moarram/headline', as:theme
zplug 'romkatv/powerlevel10k', as:theme, depth:1

# z - jump command
# https://github.com/agkozak/zsh-z
zplug "agkozak/zsh-z"

# Install plugins directly
if ! zplug check --verbose; then
	zplug install
fi

if [[ ! -e "$ZSH_HOME/flags/zplug_update_once_on_apply.flag" ]]; then
	zplug update
	touch $ZSH_HOME/flags/zplug_update_once_on_apply.flag
fi

# Then, source plugins and add commands to $PATH
zplug load
