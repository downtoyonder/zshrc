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
