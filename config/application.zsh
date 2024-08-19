# ************************************************************** #
# * 应用相关配置
# ************************************************************** #

export EDITOR="vim"

# * Conda
if [[ -d "$HOME/mambaforge-pypy3" ]]; then
    conda_provider=mambaforge-pypy3
elif [[ -d "$HOME/miniforge3" ]]; then
    conda_provider=miniforge3
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/$conda_provider/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "$HOME/$conda_provider/etc/profile.d/conda.sh" ]; then
		. "$HOME/$conda_provider/etc/profile.d/conda.sh"
	else
		export PATH="$HOME/$conda_provider/bin:$PATH"
	fi
fi
unset __conda_setup

if [ -f "$HOME/$conda_provider/etc/profile.d/mamba.sh" ]; then
	. "$HOME/$conda_provider/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# * Golang
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
PATH=$GOBIN:$GOROOT/bin:$PATH

# * delve 
if command -v dlv &>/dev/null; then
	# auto completion
	source <(dlv completion zsh)
fi

# * ent 
if command -v ent &>/dev/null; then
	# auto completion
	source <(ent completion zsh)
fi

# go-callvis
if command -v go-callvis &>/dev/null; then
    # 需要用 static 算法，其他会报错
    # 指定 -cacheDir 避免重复渲染
    alias 'go-callvis'="go-callvis -algo=static -cacheDir=./callvis"
fi

# * Rust
# . "$HOME/.cargo/env"
PATH="$HOME/.cargo/bin:$PATH"

# * Haskell
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# PlantUML Location
plant_uml="$HOME/Applications/cli_apps/plantuml-gplv2-1.2024.4.jar"

# * Java
if command -v java &>/dev/null; then
    alias 'puml'="java -jar $plant_uml"
fi

# * Gooogle Protoc
PATH=/usr/local/protoc/bin:$PATH

# * JetBrains ToolBox
PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

# * Pnpm
PATH="$HOME/.local/share/pnpm:$PATH"

# * yarn
# yarn global path
PATH="$HOME/.yarn/bin:$PATH"

# * Prometheus
PATH="$HOME/Applications/prometheus/bin:$PATH"
PATH="$HOME/Applications/node_exporter/bin:$PATH"

# * gem
export GEM_HOME="$HOME/gems"
PATH=$GEM_HOME/bin:$PATH

# * NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# * bun
export BUN_INSTALL="$HOME/.bun"
PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/home/don/.bun/_bun" ] && source "/home/don/.bun/_bun"

# * kubectl
if command -v kubectl &>/dev/null; then
	# auto completion
	source <(kubectl completion zsh)
	alias k="kubectl"
fi

# * helm
if command -v helm &>/dev/null; then
	# auto completion
	source <(helm completion zsh)
fi

# * minikube
if command -v minikube &>/dev/null; then
	# auto completion
	source <(minikube completion zsh)
	alias mk="minikube"
	alias mkk="minikube kubectl"
elif command -v microk8s &>/dev/null; then
# * microk8s 
	alias mk="microk8s"
	alias mkk="microk8s kubectl"
	alias mkh="microk8s helm"
fi

if command -v kind &>/dev/null; then
    if [[ ! -e "${fpath[1]}/_kind" ]]; then
        kind completion zsh > "${fpath[1]}/_kind"
    fi
fi

# * golangci-lint
if command -v golangci-lint &>/dev/null; then
	# auto completion
	source <(golangci-lint completion zsh)
fi

if command -v thefuck &>/dev/null; then
	# thefunk: https://github.com/nvbn/thefuck
	eval $(thefuck --alias)
fi

if command -v gh &>/dev/null; then
    # github cli and github cli copilot
    alias '#'="gh copilot suggest -t shell"
    alias '#g'="gh copilot suggest -t git"
    alias '#gh'="gh copilot suggest -t gh"
    alias '#!'="gh copilot explain"
fi

# colorful man page
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

