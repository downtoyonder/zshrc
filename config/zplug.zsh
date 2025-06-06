# ************************************************************** #
# * zplug & plugin management
# ************************************************************** #

# Using zplug as plugin manager
# Refer to https://github.com/zplug/zplug

# Only load zplug if it exists
if [[ -d "$ZSH_HOME/zplug" ]]; then
	export ZPLUG_HOME=$ZSH_HOME/zplug
	source $ZPLUG_HOME/init.zsh
else
	# If zplug doesn't exist, create a dummy function to prevent errors
	function zplug() {
		echo "zplug is not installed. Run 'make apply-config' to install it."
	}
	return
fi

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search", as:plugin, defer:3

# Supports oh-my-zsh plugins and the like
zplug "plugins/git", from:oh-my-zsh, defer:2
# 双击 ESC 自动在命令前加 sudo
zplug "plugins/sudo", from:oh-my-zsh, defer:3
# 执行 copydir 命令时，会将当前目录复制到剪贴板
zplug "plugins/copydir", from:oh-my-zsh, defer:3
# 执行 copyfile 命令时，会将目标文件内容复制到剪贴板
zplug "plugins/copyfile", from:oh-my-zsh, defer:3

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:3

# 命令建议插件
zplug "zsh-users/zsh-autosuggestions", defer:2
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# Load theme file
# zplug 'Moarram/headline', as:theme
zplug 'romkatv/powerlevel10k', as:theme, depth:1

# z - jump command
# https://github.com/agkozak/zsh-z
zplug "agkozak/zsh-z", defer:3

# https://github.com/MichaelAquilina/zsh-you-should-use
zplug "MichaelAquilina/zsh-you-should-use", defer:3

# Install plugins only if needed, and do it silently
if ! zplug check; then
	zplug install >/dev/null 2>&1 &
fi

# Update plugins only if the flag doesn't exist, and do it in the background
if [[ ! -e "$ZSH_HOME/flags/zplug_update_once_on_apply.flag" ]]; then
	(zplug update >/dev/null 2>&1 && touch $ZSH_HOME/flags/zplug_update_once_on_apply.flag) &
fi

# Then, source plugins and add commands to $PATH
zplug load
