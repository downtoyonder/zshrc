# Basic environment settings related to the zsh compiliation

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
# zsh 配置文件目录
export ZSH_HOME="$XDG_CONFIG_HOME/zshrc"
export ZSH_CONFIG="$XDG_CONFIG_HOME/zshrc/config"
export ZSH_CACHE="$XDG_CACHE_HOME/zshrc"
mkdir -p $ZSH_CACHE

# ************************************************************** #
# * 系统级环境变量
# ************************************************************** #

# Executable search path
# The default system environment contains(from first to last order): /home/don/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# 1. /home/don/.local/bin
# 2. /usr/local/sbin
# 3. /usr/local/bin
# 4. /usr/sbin
# 5. /usr/bin
# 6. /sbin
# 7. /bin
