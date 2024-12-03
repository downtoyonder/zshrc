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

g_start_time=$(date +%s.%N)
g_next_time=$g_start_time
function elapsed_time() {
	local l_start_time="$1"
	local l_operation="$2"

	if [[ -z "$l_start_time" ]]; then
		l_start_time=$g_start_time
	fi

	elapsed_time=$(printf "%.2f" $(echo "$(date +%s.%N) - $l_start_time" | bc))
	g_next_time=$(date +%s.%N)

	if [[ $PRINT_TIME_COST -eq 0 ]]; then
		return
	fi

	if [[ -z "$l_operation" ]]; then
		echo "Time comsumption: ${elapsed_time}s"
	else
		echo "Time consumption of operation \033[1;36m${l_operation}\033[0m: ${elapsed_time}s"
	fi
}

# ----------------------- GLOBAL SECTION END ------------------------



# ----------------------- DEBUG SECTION ------------------------
source "$ZSH_CONFIG/debug.zsh"

# ----------------------- DEBUG SECTION END ------------------------

if [[ -z "$sourced_zshs" ]]; then
	typeset -A sourced_zshs
fi

function source_once() {
	local file="$1"
	if [[ -n "${sourced_zshs["$file"]}" ]]; then
		if [[ $X_DEBUG -eq 1 ]]; then
			echo "File '$file' is already sourced. Skipping..."
		fi
		return 0
	else
		sourced_zshs["$file"]=1
		source "$file"
	fi
}

source_once "$ZSH_CONFIG/utils.zsh"

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

opts=("$ZSH_CONFIG/proxy.zsh" "$ZSH_CONFIG/work.zsh")

for opt in $opts[@]; do
	[[ -f $opt ]] && source_once $opt
done

# typeset -ga
# -g: This attribute makes the variable global.
#     Allowing it to be accessed and modified from within functions and subshells.
#     Without the -g attribute, the variable would be local to the current scope.
# -a: This attribute specifies that the variable is an array.
#     Arrays in Zsh can hold multiple values.

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
	"$HOME/.fzf.zsh"
)

# 应用所有 zsh 配置
for file in $sources[@]; do
	[[ -f $file ]] && source_once $file
	elapsed_time $g_next_time "source $file"
done

elapsed_time
echo "MAKE TODAY AN AMAZING DAY!!! --${elapsed_time}s"
