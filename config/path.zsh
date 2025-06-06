# ************************************************************** #
# * PATH Management
# ************************************************************** #

# This file centralizes PATH management to avoid duplication and improve performance
# It's designed to be sourced by application.zsh and other files that need to modify PATH

# Store the original PATH when zsh starts
if [[ -z "$ORIGINAL_PATH" ]]; then
	export ORIGINAL_PATH="$PATH"
fi

# Function to add a directory to PATH only if it exists and isn't already in PATH
function path_add() {
	local new_path="$1"

	# Check if directory exists
	if [[ -d "$new_path" ]]; then
		# Check if it's not already in PATH
		if [[ ":$PATH:" != *":$new_path:"* ]]; then
			PATH="$new_path:$PATH"
			return 0
		fi
	fi
	return 1
}

# Function to prepend multiple directories to PATH in the order they're given
function path_prepend() {
	local paths=("$@")
	local i

	# Process in reverse order to maintain the specified order
	for ((i = ${#paths[@]} - 1; i >= 0; i--)); do
		path_add "${paths[i]}"
	done
}

# Function to append multiple directories to PATH in the order they're given
function path_append() {
	local new_path

	for new_path in "$@"; do
		# Check if directory exists
		if [[ -d "$new_path" ]]; then
			# Check if it's not already in PATH
			if [[ ":$PATH:" != *":$new_path:"* ]]; then
				PATH="$PATH:$new_path"
			fi
		fi
	done
}

# Function to reset PATH to its original value
function path_reset() {
	if [[ -n "$ORIGINAL_PATH" ]]; then
		PATH="$ORIGINAL_PATH"
	else
		# Fallback to system default if ORIGINAL_PATH is not set
		PATH="/home/don/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
	fi
}

# Function to print the current PATH in a readable format
function path_print() {
	echo "Current PATH:"
	echo "$PATH" | tr ':' '\n' | nl
}

# Make functions available - zsh doesn't use export -f like bash
# These functions are already available in the current shell
