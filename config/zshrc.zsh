# Reset PATH to default PATH
# For more information about PATH variable, refer to environment.zsh file `系统级环境变量` part
export PATH=/home/don/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# This setting must be at the top of the file to be effective.
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block.
# Everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Slove locale problem
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# The start time
start_time=$(date +%s.%N)

# Load p10k config
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Including the environment variables
# $ZSH_CONFIG variable is avaliable only after source the environment.zsh file
if [[ ! -z "$ZSH_CONFIG" ]]; then
	source "$ZSH_CONFIG/environment.zsh"
else
	source "$HOME/.config/zshrc/config/environment.zsh"
fi

typeset -ga opts
# Empty the config array to reset PATH
opts=()
# Set Proxy
opts+="$ZSH_CONFIG/proxy.zsh"
# Environment for work
opts+="$ZSH_CONFIG/work.zsh"

# 应用可选 zsh 配置
for file in $opts[@]; do
	if [[ -f $file ]]; then
		source $file
	fi
done

# -g: This attribute makes the variable global.
#     Allowing it to be accessed and modified from within functions and subshells.
#     Without the -g attribute, the variable would be local to the current scope.
# -a: This attribute specifies that the variable is an array.
#     Arrays in Zsh can hold multiple values.
typeset -ga sources
# Empty the config array to reset PATH
sources=()

# 根据不同系统导入不同的配置文件
# MacOS: darwin.zsh
# Linux: linux.zsh
systemFile=$(uname -s | tr "[:upper:]" "[:lower:]")
sources+="$ZSH_CONFIG/$systemFile.zsh"

sources+="$ZSH_CONFIG/option.zsh"
sources+="$ZSH_CONFIG/function.zsh"
sources+="$ZSH_CONFIG/zplug.zsh"
sources+="$ZSH_CONFIG/alias.zsh"
sources+="$ZSH_CONFIG/application.zsh"

# 应用所有 zsh 配置
for file in $sources[@]; do
	if [[ -f $file ]]; then
		source $file
	fi
done

# fzf: https://github.com/junegunn/fzf?tab=readme-ov-file#installation
# Shortcut:
# CTRL+R: Paste the selected files and directories onto the command-line
# CTRL+T: Paste the selected command from history onto the command-line
# ALT+C: cd into the selected directory
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Get the end time
end_time=$(date +%s.%N)
# Calculate the elapsed time
elapsed_time=$(echo "$end_time - $start_time" | bc)
# Format the elapsed time
formatted_time=$(printf "%.2f" $elapsed_time)
# Set color variables
# magenta='\033[0;35m'
# default='\033[0m'
# Print the startup time
export zsh_startup_time=${formatted_time}s
echo "MAKE TODAY AN AMAZING DAY!!! --" $zsh_startup_time
