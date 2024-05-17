#!/bin/bash

apt_updated=0

function apt_install() {
	if [[ -z "$@" ]]; then
		return
	fi

	if [[ "$apt_updated" -eq 0 ]]; then
		apt_updated=1
		apt update
	fi

	apt install -y $@
}

alias installer="apt_install"
