# Basic environment settings related to the zsh compiliation

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh 配置文件目录
export ZSH_HOME="$XDG_CONFIG_HOME/zshrc"
export ZSH_CONFIG="$XDG_CONFIG_HOME/zshrc/config"
export ZSH_CACHE="$XDG_CACHE_HOME/zshrc"
mkdir -p $ZSH_CACHE

# Slove locale problem
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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


# ************************************************************** #
# * Application level environments
# ************************************************************** #

# [openrouter] Free Key
export TMUXAI_OPENROUTER_API_KEY=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

