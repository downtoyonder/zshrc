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
