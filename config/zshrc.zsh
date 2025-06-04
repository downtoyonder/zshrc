# ----------------------- GLOBAL SECTION ------------------------

# Reset PATH to default PATH
# For more information about PATH variable, refer to environment.zsh file `系统级环境变量` part
export PATH=/home/don/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Including the environment variables
# $ZSH_CONFIG variable is avaliable only after source the environment.zsh file
if [[ ! -z "$ZSH_CONFIG" ]]; then
	source "$ZSH_CONFIG/environment.zsh"
else
	source "$HOME/.config/zshrc/config/environment.zsh"
fi

# DEBUG
[[ ! -f $ZSH_CONFIG/debug.zsh ]] || source $ZSH_CONFIG/debug.zsh

# ----------------------- MAIN SECTION ------------------------

# This will introduce functions:
# - source_once
# - elapsed_time
# - lazy_completion
source "$ZSH_CONFIG/utils.zsh"

# This setting must be at the top of the file to be effective.
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block.
# Everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source_once "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load p10k config
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source_once ~/.p10k.zsh


opts=(
	"$ZSH_CONFIG/proxy.zsh"
	"$ZSH_CONFIG/work.zsh"
	"$ZSH_CONFIG/keys.zsh"
)

for opt in "$opts[@]"; do
	[[ -f $opt ]] && source $opt
done

sources=(
	"$ZSH_CONFIG/alias.zsh"
	"$ZSH_CONFIG/option.zsh"
	"$ZSH_CONFIG/zplug.zsh"
	# 根据不同系统导入不同的配置文件
	# MacOS: darwin.zsh
	# Linux: linux.zsh
	"$ZSH_CONFIG/$(uname -s | tr "[:upper:]" "[:lower:]").zsh"
	"$ZSH_CONFIG/application.zsh"
	"$ZSH_CONFIG/function.zsh"
)

# 应用所有 zsh 配置
for file in "$sources[@]"; do
	[[ -f $file ]] && source_once $file
	elapsed_time "source $file"
done

elapsed_time "finalizer"