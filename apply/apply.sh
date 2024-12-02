#!/bin/bash

# Set exit on error
set -e

# 目标软件
blue_print=("zsh" "git" "make" "curl" "bc")
# 支持的平台
support_platforms=("linux" "darwin")
# 表示 apply.sh 已经执行过的 flag
apply_flag="flags/apply.flag"

# 创建 flags 文件夹
mkdir -p flags

# 如果已经执行过 apply.sh 则退出
if [[ -e "$apply_flag" ]]; then
	echo "already apply the zshrc config"
	exit 0
fi

# To lower case
platform=$(uname | tr '[:upper:]' '[:lower:]')
for supported_platform in "${support_platforms[@]}"; do
	if [[ "${platform}" == "${supported_platform}" ]]; then
		break # Platform is supported, continue execution
	fi
done

# 如果不支持当前平台则退出
if [[ "${platform}" != "${supported_platform}" ]]; then
	echo "This script is for Linux and Darwin currently"
	exit 0
fi

# shellcheck source=apply/linux.sh
# shellcheck source=apply/darwin.sh
source "apply/${platform}.sh"

# 筛选出需要安装的软件
to_install=()
for app in "${blue_print[@]}"; do
	if ! [[ $(command -v "$app") ]]; then
		echo "$app is not installed, it will be installed"
		to_install+=("$app")
	fi
done

# 获取对应平台的 installer
# zsh_installer is load from apply/"$platform".sh
zsh_installer "${to_install[@]}"

# 设置 zsh 为默认 shell
# Check if zsh is the default shell
# *zsh 表示正则表达式匹配
if [[ $SHELL != *zsh ]]; then
	echo "zsh is not the default shell. Set zsh as default shell"
	chsh -s "$(which zsh)"
fi

if [ ! -d "zplug/.git" ]; then
	git submodule update --init
fi

# 删除原有的 zshrc 文件，创建软链接
rm -f ~/.zshrc
ln config/zshrc.zsh ~/.zshrc

if [[ -z "$ZSH_CONFIG" ]]; then
	ZSH_CONFIG=$(pwd)/config
	export ZSH_CONFIG
fi

# 创建 apply flag 文件，表示 apply.sh 已经执行过
touch "$apply_flag"

# Start a new zsh instead of the current shell interpreter process
exec zsh --login
