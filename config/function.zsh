function lk {
	cd "$(walk "$@")"
}

function prev() {
	PREV=$(fc -lrn | head -n 1)
	sh -c "pet new $(printf %q "$PREV")"
}

function set_proxy() {
	proxy_file="$ZSH_CONFIG/proxy.zsh"
	if [[ -f "$proxy_file" ]]; then
		source "$proxy_file"
	fi
}

function unset_proxy() {
	unset http_proxy
	unset https_proxy
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset NO_PROXY
}

function show_proxy() {
	echo "http_proxy:   $http_proxy"
	echo "https_proxy:  $https_proxy"
	echo "HTTP_PROXY:   $HTTP_PROXY"
	echo "HTTPS_PROXY:  $HTTPS_PROXY"
	echo "NO_PROXY:     $NO_PROXY"
}
