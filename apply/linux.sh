#!/bin/bash

if [[ "$platform" != "linux" ]]; then
	echo "This script is for Linux only"
	exit 0
fi

debian_config="apply/linux_debian.sh"

debian="debian"
ubuntu="ubuntu"
mint="linuxmint"
debian_like=("$debian" "$ubuntu" "$mint")

distros+=("${debian_like[@]}")
declare -A distro_map

for distro in "${debian_like[@]}"; do
	distro_map["$distro"]="$debian_config"
done

# 拿到当前发行版
curr_distro=$(grep '^NAME=' /etc/os-release | awk -F= '{print $2}' | tr -d '"')

# is current release supported
is_supported=0

for distro in "${distros[@]}"; do
	if [[ "$curr_distro" == "$distro" ]]; then
		echo "Found $distro"
		is_supported=1
	fi
done

if [[ ! "$is_supported" ]]; then
	echo "Your release is not supported, only support" "${distros[@]}"
	exit 0
fi

distro_config=${distro_map["$curr_distro"]}

# 加载当前发行版配置，这会拿到该发行版的 installer 函数
source "$distro_config"

# linux 系统需要设置 locale 以设置语言

if ! [[ $(command -v locale-gen) ]]; then
	zsh_installer "locales"
fi

# Set the locale
# Need root privilege
if [[ $(id | grep -c "gid=0") == 1 ]]; then
	locale-gen en_US.UTF-8
elif [[ $(id | grep -c sudo) == 1 ]]; then
	sudo locale-gen en_US.UTF-8
else
	echo "You need root privilege to set locale, or manually call $(sudo locale-gen en_US.UTF-8)"
fi
