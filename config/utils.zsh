function colored_text() {
	local text="$1"
	local color="$2"
	local style="${3:-normal}" # Default style is "normal"

	# Declare associative arrays for color and style codes
	declare -A COLOR_CODES=(
		["black"]="30" ["red"]="31" ["green"]="32" ["yellow"]="33"
		["blue"]="34" ["magenta"]="35" ["cyan"]="36" ["white"]="37"
	)
	declare -A STYLE_CODES=(
		["normal"]="0" ["bold"]="1" ["underline"]="4"
	)

	# Get the color and style codes
	local color_code="${COLOR_CODES[$color]:-37}" # Default to white if not found
	local style_code="${STYLE_CODES[$style]:-0}"  # Default to normal if not found

	# Return the colored text
	echo -e "\033[${style_code};${color_code}m${text}\033[0m"
}

# Define lazy loading mechanism
function lazy_load_completion() {
	local command=$1
	local completion_script=$2

	eval "
    function $command() {
        unfunction $command
        source <($completion_script)
        $command \"\$@\"
    }
    "
}

if [[ -z "$sourced_zshs" ]]; then
	typeset -A sourced_zshs
fi

if [[ -z "$source_once_list" ]]; then
	typeset -A source_once_list
	# 顺序很重要
	source_once_list["${ZSH_CONFIG}/option.zsh"]=1
	source_once_list["${ZSH_CONFIG}/zplug.zsh"]=1
	source_once_list["${ZSH_CONFIG}/$(uname -s | tr "[:upper:]" "[:lower:]").zsh"]=1
	source_once_list["${ZSH_CONFIG}/function.zsh"]=1
fi

function source_once() {
	local file="$1"

	if [[ ! -n "${source_once_list["$file"]}" ]]; then
		source "$file"
		return 0
	fi

	if [[ -n "${sourced_zshs["$file"]}" ]]; then
		if [[ $PRINT_SOURCED_FILE -eq 1 ]]; then
			echo "File '$file' is already sourced. Skipping..."
		fi
		return 0
	else
		sourced_zshs["$file"]=1
		source "$file"
	fi
}

g_start_time=$(date +%s.%N)
g_time_anchor=$g_start_time

function elapsed_time() {
	# Function to calculate and print elapsed time
	# Usage:
	# - elapsed_time [start_time] [operation_name]
	# - elapsed_time [operation_name]
	#   If only one argument is provided, it is treated as the operation name and uses the global time anchor.
	#   If the operation_name is "finalizer", it will print the startup prompt.
	# - elapsed_time
	#   If no arguments are provided, it uses the global time anchor and prints the elapsed time with an operation name "total"

	if [[ $# -eq 0 ]]; then
		local l_operation="total startup"
		local l_start_time=$g_start_time
	elif [[ $# -eq 1 ]]; then
		local l_operation="$1"

		if [[ "$l_operation" == "finalizer" ]]; then
			local l_start_time=$g_start_time
		else
			local l_start_time=$g_time_anchor
		fi
	elif [[ $# -eq 2 ]]; then
		local l_start_time="$1"
		local l_operation="$2"
	fi

	local l_elapsed_time
	if command -v bc >/dev/null 2>&1; then
		l_elapsed_time=$(printf "%.2f" $(echo "$(date +%s.%N) - $l_start_time" | bc))
	else
		# Fallback calculation using zsh arithmetic
		local end_time=$(date +%s.%N)
		l_elapsed_time=$(printf "%.2f" $((end_time - l_start_time)))
	fi
	g_time_anchor=$(date +%s.%N)

	if [[ "$l_operation" == "finalizer" ]]; then
		echo "🚀 \033[1;32mMAKE TODAY AN AMAZING DAY!!!\033[0m --${l_elapsed_time}s"
		return
	fi

	if [[ $PRINT_TIME_COST -eq 0 ]]; then
		return
	fi

	if [[ -z "$l_operation" ]]; then
		echo "Time consumption: ${l_elapsed_time}s"
	else
		echo "Time consumption of operation \033[1;36m${l_operation}\033[0m: ${l_elapsed_time}s"
	fi
}
