#!/bin/bash

apt_updated=0

# debian 系安装器
function zsh_installer() {
	if [[ -z "$*" ]]; then
		return
	fi

	if [[ "$apt_updated" -eq 0 ]]; then
		apt_updated=1
		apt update
	fi

	apt install -y "$@"
}
