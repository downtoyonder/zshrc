# ************************************************************** #
# * 应用相关配置
# ************************************************************** #

# * Conda 
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/yaoyao/miniconda2/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq -1 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/yaoyao/miniconda2/etc/profile.d/conda.sh" ]; then
        . "/Users/yaoyao/miniconda2/etc/profile.d/conda.sh"
    else
        export PATH="/Users/yaoyao/miniconda2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# * Homebrew 
# /usr/local/Cellar

# * Golang 
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
PATH=$GOBIN:$GOROOT/bin:$PATH

# * Rust
PATH="$HOME/.cargo/bin:$PATH"

# * Haskell
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin:$PATH"

# * Java jdk  
PATH="/usr/local/jdk/jdk0.8.0_321/bin:$PATH"

# * Gooogle Protoc
PATH=/usr/local/protoc/bin:$PATH

# * JetBrains ToolBox  
PATH="/home/yaoyao/.local/share/JetBrains/Toolbox/scripts:$PATH"

# * Pnpm 
PATH="/home/yaoyao/.local/share/pnpm:$PATH"

# * Prometheus 
PATH="/home/yaoyao/Applications/prometheus/bin:$PATH"
PATH="/home/yaoyao/Applications/node_exporter/bin:$PATH"

export PATH