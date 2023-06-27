# Get the start time
start_time=$(date +%s.%N)

## First, including the environment variables
source $HOME/.config/zshrc/config/environment.zsh

if [ -f $HOME/.config/zshrc/proxy/proxy.zsh ]; then
	source $HOME/.config/zshrc/proxy/proxy.zsh
fi

# -g: This attribute makes the variable global.
#     Allowing it to be accessed and modified from within functions and subshells.
#     Without the -g attribute, the variable would be local to the current scope.
# -a: This attribute specifies that the variable is an array.
#     Arrays in Zsh can hold multiple values.
typeset -ga sources
sources+="$ZSH_CONFIG/applications.zsh"
sources+="$ZSH_CONFIG/options.zsh"
sources+="$ZSH_CONFIG/functions.zsh"
sources+="$ZSH_CONFIG/alias.zsh"
sources+="$ZSH_CONFIG/zplug.zsh"

# 根据不同系统导入不同的配置文件
# MacOS: darwin.zsh
# Linux: linux.zsh
systemFile=$(uname -s | tr "[:upper:]" "[:lower:]")
sources+="$ZSH_CONFIG/$systemFile.zsh"

# 遍历数组应用所有 zsh 配置
for file in $sources[@]; do
	if [[ -f $file ]]; then
		source $file
	fi
done

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Get the end time
end_time=$(date +%s.%N)
# Calculate the elapsed time
elapsed_time=$(echo "$end_time - $start_time" | bc)
# Format the elapsed time
formatted_time=$(printf "%.2f" $elapsed_time)
# Set color variables
magenta='\033[0;35m'
default='\033[0m'
# Print the startup time
export zsh_startup_time=${formatted_time}s
echo "MAKE TODAY AN AMAZING DAY!!!"
