# reset PATH to default PATH
export PATH=/home/don/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Get the start time
start_time=$(date +%s.%N)

## Set Proxy
if [ -f $HOME/.config/zshrc/config/proxy.zsh ]; then
	source $HOME/.config/zshrc/config/proxy.zsh
fi

# Environment for work
if [ -f $HOME/.config/zshrc/config/work.zsh ]; then
	source $HOME/.config/zshrc/config/work.zsh
fi

## Including the environment variables
source $HOME/.config/zshrc/config/environment.zsh


# -g: This attribute makes the variable global.
#     Allowing it to be accessed and modified from within functions and subshells.
#     Without the -g attribute, the variable would be local to the current scope.
# -a: This attribute specifies that the variable is an array.
#     Arrays in Zsh can hold multiple values.
typeset -ga sources
# empty the config array to reset PATH
sources=()
sources+="$ZSH_CONFIG/options.zsh"
sources+="$ZSH_CONFIG/zplug.zsh"
sources+="$ZSH_CONFIG/alias.zsh"
sources+="$ZSH_CONFIG/applications.zsh"

# 根据不同系统导入不同的配置文件
# MacOS: darwin.zsh
# Linux: linux.zsh
systemFile=$(uname -s | tr "[:upper:]" "[:lower:]")
sources+="$ZSH_CONFIG/$systemFile.zsh"

# 应用所有 zsh 配置
for file in $sources[@]; do
	if [[ -f $file ]]; then
		source $file
	fi
done

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
echo "MAKE TODAY AN AMAZING DAY!!!"
