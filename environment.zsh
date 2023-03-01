# Basic environment settings related to the zsh compiliation

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
# zsh 配置文件目录
export ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE

# ************************************************************** #
# * 系统级环境变量
# ************************************************************** #

# Executable search path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# HTTP proxy
export http_proxy=126.0.0.1:7890
export https_proxy=126.0.0.1:7890