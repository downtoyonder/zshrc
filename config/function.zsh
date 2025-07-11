function lk {
	cd "$(walk "$@")"
}

function prev() {
	PREV=$(fc -lrn | head -n 1)
	sh -c "pet new $(printf %q "$PREV")"
}

function set_proxy() {
	[[ -f "$proxy_file" ]] && source "$ZSH_CONFIG/proxy.zsh"
}

function unset_proxy() {
	env | grep -i proxy | while IFS= read -r line; do
		var_name=$(echo "$line" | cut -d'=' -f1)
		unset $var_name
	done
}

function show_proxy() {
	env | grep -i proxy
}

function len() {
	echo $(expr length "$*")
}

function cpb() {
	echo $(xclip -selection clipboard -o)
}

# https://github.com/colin-scott/interactive_latencies
# latency numbers every programmers should know
function lat() {
	curl cheat.sh/latencies
}

function ts_date() {
	if [[ $# -eq 0 ]]; then
		echo "need at least one timestamp argument, like 'ts_date 946656000'"
		return 0
	fi

	for ts in "$@"; do
		if ! [[ "$ts" =~ ^[0-9]+$ ]]; then
			echo "Error: argument '$ts' must be an integer timestamp"
			continue
		fi

		# Check if the timestamp is in milliseconds (length > 10)
		if [[ ${#ts} -gt 10 ]]; then
			# Convert milliseconds to seconds
			tss=$((ts / 1000))
		fi

		echo -n "ts:$ts --> "
		date -d @$tss '+%Y-%m-%d %H:%M:%S'
	done
}

function is_appimage() {
	if [[ $# -eq 0 ]]; then
		echo "Check if a file is an AppImage\n"
		echo "Usage: is_appimage <file>"
		return 0
	fi

	file="$1"

	if [[ ! -f "$file" ]]; then
		echo "File '$file' does not exist."
		return 1
	fi

	local magic
	magic=$(dd if="$file" bs=1 skip=8 count=3 2>/dev/null | od -An -t x1 | tr -d ' \n')

	case "$magic" in
	414902) # "AI\x02" (type 2 AppImage)
		echo "✅ Detected AppImage type 2"
		return 0
		;;
	414901) # "AI\x01" (type 1 AppImage)
		echo "✅ Detected AppImage type 1"
		return 0
		;;
	*)
		echo "❌ Not an AppImage"
		return 1
		;;
	esac

}

function add_alias() {
	if [[ $# -eq 0 ]]; then
		echo "Add new alias to zshrc/alias.zsh file"
		echo "Take effects after command completes\n"
		echo "Usage: add_alias [-f] <alias> <target file path related to current>"
		echo "  -f    Force overwrite if alias already exists"
		return 0
	fi

	# Parse arguments
	local force=false
	local args=("$@")
	local arg_index=1

	# Check for -f flag
	if [[ "${args[1]}" == "-f" ]]; then
		force=true
		arg_index=2
	fi

	# Get alias name and file path based on whether -f was used
	alias_name="${args[$arg_index]}"
	file="${args[$((arg_index + 1))]}"

	if [[ -z "$alias_name" || -z "$file" ]]; then
		echo "Error: Missing required arguments."
		echo "Usage: add_alias [-f] <alias> <target file path related to current>"
		return 1
	fi

	if [[ ! -f "$file" ]]; then
		echo "File '$file' does not exist."
		return 1
	fi

	# Get absolute path of the file
	absolute_path=$(realpath "$file")

	# Check if the alias already exists
	if alias "$alias_name" &>/dev/null; then
		if [[ "$force" == true ]]; then
			echo "Alias '$alias_name' exists. Removing it due to -f flag..."

			# Unalias it immediately
			unalias "$alias_name"

			# Remove the line from alias.zsh file
			# Create a temporary file
			temp_file=$(mktemp)

			# Filter out the line with the alias
			grep -v "alias $alias_name=" "$ZSH_CONFIG/alias.zsh" >|"$temp_file"

			# Copy the content back to the original file to preserve permissions and ownership
			cat "$temp_file" >|"$ZSH_CONFIG/alias.zsh"

			# Remove the temporary file
			rm "$temp_file"
		else
			echo "Warning: Alias '$alias_name' already exists."
			echo "Use -f flag to force overwrite."
			return 1
		fi
	fi

	# Set the alias immediately
	alias "$alias_name"="$absolute_path"

	# Add the alias to the alias.zsh file
	echo "alias $alias_name=\"$absolute_path\"" >>"$ZSH_CONFIG/alias.zsh"

	echo "✅ Alias '$alias_name' added successfully."
}
