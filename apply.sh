#!/bin/bash

if [[ -e "apply.flag" ]]; then
	echo "already apply the zshrc"
	exit 0
fi

touch apply.flag

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

if [[ -z "$ZSH_CONFIG" ]]; then
	export ZSH_CONFIG=$(pwd)/config
fi

debian="Debian"
ubuntu="Ubuntu"
linux_mint="Linux Mint"
fedora="Fedora" # To be implemented
arch="Arch"     # To be implemented

# issues=("$debian" "$ubuntu" "$linux_mint" "$fedora" "$arch")
issues=("$debian" "$ubuntu" "$linux_mint")
# is current release supported
hit=0

cur_issue=$(head -1 /etc/os-release | cut -d '"' -f2)

for issue in "${issues[@]}"; do
	if [[ "$cur_issue" == "$issue" ]]; then
		echo "Found "$issue""
		hit=1
	fi
done

if [[ ! "$hit" ]]; then
	echo "Your release is not supported"
	exit 0
fi

# hit = 1
to_install=()
# Check if zsh is installed
if ! [[ $(command -v zsh) ]]; then
	echo "zsh is not installed. zsh will be installed"
	to_install+=("zsh")
fi

if ! [[ $(command -v git) ]]; then
	echo "git is not installed. git will be installed"
	to_install+=("git")
fi

# zsh plug p10k dependency
if ! [[ $(command -v curl) ]]; then
	echo "curl is not installed. curl will be installed"
	to_install+=("curl")
fi

if ! [[ $(command -v locale-gen) ]]; then
	echo "locales is not installed. locales will be installed"
	to_install+=("locales")
fi

apt_install ${to_install[@]}

# Set the locale
locale-gen en_US.UTF-8

# Check if zsh is the default shell
if [[ $SHELL != *zsh* ]]; then
	echo "zsh is not the default shell. Set zsh as default shell"
	chsh -s $(which zsh)
fi

if [ ! -d "zplug/.git" ]; then
	git submodule update --init
fi

rm -f ~/.zshrc
ln config/zshrc.zsh ~/.zshrc

# enter zsh
zsh
