#!/bin/bash

function zsh_installer() {
	if [[ -z "$*" ]]; then
		return
	fi

	# 可能没有 homebrew，需要安装

	brew install -y "$@"
}
