#!/bin/bash

apt_updated=0

function installer() {
	if [[ -z "$@" ]]; then
		return
	fi

	if [[ "$apt_updated" -eq 0 ]]; then
		apt_updated=1
		apt update
	fi

	apt install -y $@
}
