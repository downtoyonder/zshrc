#!/bin/bash

apt_updated=0

function zsh_installer() {
	if [[ -z "$@" ]]; then
		return
	fi

	brew install -y $@
}
