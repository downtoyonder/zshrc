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
