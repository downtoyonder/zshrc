# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# first include of the environment
source $HOME/.config/zsh/environment.zsh

# -g 设置为全局变量，即使在函数内也生效
# -a 设置变量为数组
typeset -ga sources
sources+="$ZSH_CONFIG/applications.zsh"
sources+="$ZSH_CONFIG/options.zsh"
sources+="$ZSH_CONFIG/prompt.zsh"
sources+="$ZSH_CONFIG/fzf.zsh"
sources+="$ZSH_CONFIG/alias.zsh"
sources+="$ZSH_CONFIG/zplug.zsh"

# 根据不同系统导入不同的配置文件
# MacOS: darwin.zsh
# Linux: linux.zsh
systemFile=`uname -s | tr "[:upper:]" "[:lower:]"`
sources+="$ZSH_CONFIG/$systemFile.zsh"

# 遍历数组应用所有 zsh 配置
foreach file (`echo $sources`)
    if [[ -a $file ]]; then
        # sourceIncludeTimeStart=$(gdate +%s%N)
        source $file
        # sourceIncludeDuration=$((($(gdate +%s%N) - $sourceIncludeTimeStart)/1000000))
        # echo $sourceIncludeDuration ms runtime for $file
    fi
end

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh