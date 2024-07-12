# Reset PATH to default PATH
# For more information about PATH variable, refer to environment.zsh file `系统级环境变量` part
export PATH=/home/don/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 启动 zsh 时打印 zsh 加载的配置文件
# setopt SOURCE_TRACE

# The start time
start_time=$(date +%s.%N)

# This setting must be at the top of the file to be effective.
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block.
# Everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

opts=("$ZSH_CONFIG/proxy.zsh" "$ZSH_CONFIG/work.zsh")

for opt in $opts[@]; do
	[[ -f $opt ]] && source $opt
done

# typeset -ga
# -g: This attribute makes the variable global.
#     Allowing it to be accessed and modified from within functions and subshells.
#     Without the -g attribute, the variable would be local to the current scope.
# -a: This attribute specifies that the variable is an array.
#     Arrays in Zsh can hold multiple values.
typeset -ga sources

# 根据不同系统导入不同的配置文件
# MacOS: darwin.zsh
# Linux: linux.zsh
sources+="$ZSH_CONFIG/$(uname -s | tr "[:upper:]" "[:lower:]").zsh"
sources+="$ZSH_CONFIG/option.zsh"
sources+="$ZSH_CONFIG/function.zsh"
sources+="$ZSH_CONFIG/zplug.zsh"
sources+="$ZSH_CONFIG/alias.zsh"
sources+="$ZSH_CONFIG/application.zsh"
# fzf: https://github.com/junegunn/fzf?tab=readme-ov-file#installation
sources+="$HOME/.fzf.zsh"

# 应用所有 zsh 配置
for file in $sources[@]; do
	[[ -f $file ]] && source $file
done

# The elapsed time
elapsed_time=$(printf "%.2f" $(echo "$(date +%s.%N) - $start_time" | bc)) 

echo "MAKE TODAY AN AMAZING DAY!!! --${elapsed_time}s"