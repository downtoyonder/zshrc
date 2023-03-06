# ************************************************************** #
# * zplug & plugin management
# ************************************************************** #
export ZPLUG_HOME=$ZSH_HOME/zplug
source $ZPLUG_HOME/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/sudo",   from:oh-my-zsh

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

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 
