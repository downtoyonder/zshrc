#!/bin/bash

# Set exit on error
set -e

# 目标软件
blue_print=("zsh" "git" "make" "curl")
support_platform=("linux", "darwin")
apply_flag="flags/apply.flag"

mkdir -p flags

if [[ -e "$apply_flag" ]]; then
	echo "already apply the zshrc config"
	exit 0
fi

platform=$(uname | tr 'A-Z' 'a-z') # to lower case
if [[ ! "${support_platform[@]}" =~ "${platform}" ]]; then
	echo "This script is for Linux and Darwin only"
	exit 0
fi

source apply/"$platform".sh

# hit = 1
to_install=()
for app in "${blue_print[@]}"; do
	if ! [[ $(command -v $app) ]]; then
		echo "$app is not installed. $app will be installed"
		to_install+=("$app")
	fi
done

# zsh_installer is load from apply/"$platform".sh
zsh_installer ${to_install[@]}

# Check if zsh is the default shell
# *zsh 表示正则表达式匹配
if [[ $SHELL != *zsh ]]; then
	echo "zsh is not the default shell. Set zsh as default shell"
	chsh -s $(which zsh)
fi

if [ ! -d "zplug/.git" ]; then
	git submodule update --init
fi

rm -f ~/.zshrc
ln config/zshrc.zsh ~/.zshrc

if [[ -z "$ZSH_CONFIG" ]]; then
	export ZSH_CONFIG=$(pwd)/config
fi

touch "$apply_flag"

# Start a new zsh instead of the current shell interpreter process
exec zsh --login
